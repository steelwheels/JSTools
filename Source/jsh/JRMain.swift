/**
 * @file	JRMain.swift
 * @brief	Define main function for jsh
 * @par Copyright
 *   Copyright (C) 2019 Steel Wheels Project
 */

import CoconutData
import CoconutShell
import KiwiShell
import KiwiLibrary
import KiwiEngine
import JavaScriptCore
import Foundation

enum Package {
case resource(KEResource)
case files(Array<String>)
case error(NSError)
}

public func main(arguments args: Array<String>) -> Int32
{
	/* Parse command line arguments */
	let instrm  : CNFileStream = .fileHandle(FileHandle.standardInput)
	let outstrm : CNFileStream = .fileHandle(FileHandle.standardOutput)
	let errstrm : CNFileStream = .fileHandle(FileHandle.standardError)
	let console = CNFileConsole(input: FileHandle.standardInput, output: FileHandle.standardOutput, error: FileHandle.standardError)
	let parser  = JRCommandLineParser(console: console)
	guard let (config, arguments) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	/* Prepare context */
	guard let vm = JSVirtualMachine() else {
		console.error(string: "Failed to allocate VM\n")
		return 1
	}
	let compconf = KHConfig(applicationType: .terminal, hasMainFunction: config.doUseMain, doStrict: config.doStrict, logLevel: config.logLevel)

	/* Prepare environment variable */
	let environment = CNEnvironment()

	/* Prepare process manager */
	let procmgr = CNProcessManager()

	/* Prepare dispatch queue */
	let queue = DispatchQueue(label: "jsh", qos: .default, attributes: .concurrent)

	let files = config.scriptFiles
	if files.count == 0 || config.isInteractiveMode {
		/* Execute shell */
		let emptyres = KEResource(baseURL: Bundle.main.bundleURL)
		return executeShell(virtualMachine: vm, processManager: procmgr, queue: queue, input: instrm, output: outstrm, error: errstrm, scriptFiles: files, environment: environment, resource: emptyres, config: compconf)
	} else {
		/* Decide packaging */
		var resource: KEResource? = nil
		let stmts: Array<String>
		switch allocatePackage(scriptFiles: files) {
		case .files(let files):
			/* Read files */
			if let ss = readFiles(fileNames: files, console: console) {
				stmts = ss
			} else {
				return 1
			}
		case .resource(let res):
			/* Read resource */
			if let ss = readResource(resource: res, console: console) {
				stmts = ss
			} else {
				return 1
			}
			resource = res
		case .error(let err):
			console.error(string: "\(err.toString())\n")
			return 1
		}

		/* Translate shell script to JavaScript */
		guard let modstmts = convertShellStatements(statements: stmts, console: console) else {
			return 1
		}

		if config.isCompileMode {
			/* Dump statement instead */
			for stmt in modstmts {
				console.print(string: stmt + "\n")
			}
			return 0
		} else {
			/* Get resource */
			if resource == nil {
				resource = KEResource(baseURL: Bundle.main.bundleURL)
			}
			/* Allocate script */
			let modscr = modstmts.joined(separator: "\n")
			/* Execute script */
			return executeScript(virtualMachine: vm, processManager: procmgr, queue: queue, input: instrm, output: outstrm, error: errstrm, script: modscr, arguments: arguments, environment: environment, resource: resource!, config: compconf)
		}
	}
}

private func allocatePackage(scriptFiles files: Array<String>) -> Package {
	let result: Package
	switch files.count {
	case 0:
		result = .error(NSError.fileError(message: "No script file"))
	case 1:
		/* Accept "*.js" or "*.jspkg" file */
		let path = NSString(string: files[0])
		switch path.pathExtension {
		case "jspkg":
			result = allocatePackage(file: files[0])
		default:
			result = allocateFiles(files: files)
		}
	default:
		/* Accept multiple js files */
		result = allocateFiles(files: files)
	}
	return result
}

private func allocatePackage(file fl: String) -> Package {
	let url    = URL(fileURLWithPath: fl)
	let res    = KEResource(baseURL: url)
	let loader = KEManifestLoader()
	if let err = loader.load(into: res) {
		return .error(err)
	} else {
		return .resource(res)
	}
}

private func allocateFiles(files fls: Array<String>) -> Package {
	for f in fls {
		let path = NSString(string: f)
		let ext  = path.pathExtension
		if ext != "js" && ext != "jsh" {
			return .error(NSError.fileError(message: "Unexpected file: \(f)"))
		}
	}
	return .files(fls)
}

private func readFiles(fileNames files: Array<String>, console cons: CNConsole) -> Array<String>? {
	var stmts: Array<String> = []
	for file in files {
		let url = URL(fileURLWithPath: file)
		if let scr = url.loadContents() {
			/* Split by newline */
			let sstmts = scr.components(separatedBy: "\n")
			stmts.append(contentsOf: sstmts)
		} else {
			cons.error(string: "[Error] File is not found: \(file)\n")
			return nil
		}
	}
	return stmts
}

private func readResource(resource res: KEResource, console cons: CNConsole) -> Array<String>? {
	var result: Array<String> = []
	/* Load library */
	if let libnum = res.countOfLibraries() {
		for i in 0..<libnum {
			if let scr = res.loadLibrary(index: i) {
				/* Split by newline */
				let stmts = scr.components(separatedBy: "\n")
				result.append(contentsOf: stmts)
			} else {
				let name: String
				if let n = res.pathStringOfLibrary(index: i) {
					name = n
				} else {
					name = "<unknown>"
				}
				cons.error(string: "[Error] Failed to load library: \(name)")
				return nil
			}
		}
	}
	/* Load main scripts */
	let SCRIPT_NAME = "main"
	if let mainnum = res.countOfScripts(identifier: SCRIPT_NAME) {
		for i in 0..<mainnum {
			if let scr = res.loadScript(identifier: SCRIPT_NAME, index: i) {
				/* Split by newline */
				let stmts = scr.components(separatedBy: "\n")
				result.append(contentsOf: stmts)
			} else {
				let name: String
				if let n = res.pathStringOfLibrary(index: i) {
					name = n
				} else {
					name = "<unknown>"
				}
				cons.error(string: "[Error] Failed to load script: \(name)")
				return nil
			}
		}
	}

	return result
}

private func convertShellStatements(statements stmts: Array<String>, console cons: CNConsole) -> Array<String>?
{
	let result: Array<String>?
	let parser = KHShellParser()
	switch parser.parse(lines: stmts) {
	case .ok(let stmt1):
		let stmt2 = KHCompileShellStatement(statements: stmt1)
		result = KHGenerateScript(from: stmt2)
	case .error(let err):
		let errobj = err as NSError
		cons.error(string: "[Error] " + errobj.toString() + "\n")
		result = nil
	}
	return result
}

private func executeShell(virtualMachine vm: JSVirtualMachine, processManager procmgr: CNProcessManager, queue disque: DispatchQueue, input instrm: CNFileStream, output outstrm: CNFileStream, error errstrm: CNFileStream, scriptFiles files: Array<String>, environment env: CNEnvironment, resource res: KEResource, config conf: KHConfig) -> Int32
{
	let shell = KHShellThreadObject(virtualMachine: vm, processManager: procmgr, queue: disque, input: instrm, output: outstrm, error: errstrm, environment: env, resource: res, config: conf)
	shell.start(argument: .nullValue)
	return shell.waitUntilExit()
}

private func executeScript(virtualMachine vm: JSVirtualMachine, processManager procmgr: CNProcessManager, queue disque: DispatchQueue, input instrm: CNFileStream, output outstrm: CNFileStream, error errstrm: CNFileStream, script scr: String, arguments args: Array<String>, environment env: CNEnvironment, resource res: KEResource, config conf: KHConfig) -> Int32
{
	let thread  = KHScriptThreadObject(virtualMachine: vm, script: .script(scr), processManager: procmgr, queue: disque, input: instrm, output: outstrm, error: errstrm, environment: env, resource: res, config: conf)

	/* Convert argument */
	var nargs: Array<CNNativeValue> = []
	for arg in args {
		nargs.append(.stringValue(arg))
	}
	thread.start(argument: .arrayValue(nargs))
	return thread.waitUntilExit()
}

