/**
 * @file	JRMain.swift
 * @brief	Define main function for JSH
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
	let inhdl   = FileHandle.standardInput
	let outhdl  = FileHandle.standardOutput
	let errhdl  = FileHandle.standardError
	let console = CNFileConsole(input: inhdl, output: outhdl, error: errhdl)
	let parser  = JRCommandLineParser(console: console)
	guard let (config, arguments) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	/* Prepare context */
	guard let vm = JSVirtualMachine() else {
		console.error(string: "Failed to allocate VM\n")
		return 1
	}
	let compconf = KHConfig(kind: .Terminal, hasMainFunction: config.doUseMain, doStrict:true, doVerbose: config.doVerbose)
	let env      = CNShellEnvironment()

	let files = config.scriptFiles
	if files.count == 0 || config.isInteractiveMode {
		/* Execute shell */
		return executeShell(virtualMachine: vm, input: inhdl, output: outhdl, error: errhdl, scriptFiles: files, environment: env, config: compconf)
	} else {
		/* Decide packaging */
		let stmts: Array<String>
		switch allocatePackage(scriptFiles: files) {
		case .files(let files):
			/* Read files */
			if let ss = readFiles(fileNames: files, console: console) {
				stmts = ss
			} else {
				return 1
			}
		case .resource(let resource):
			/* Read resource */
			if let ss = readResource(resource: resource, console: console) {
				stmts = ss
			} else {
				return 1
			}
		case .error(let err):
			errhdl.write(string: "[Error] \(err.toString())\n")
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
			/* Execute script */
			return executeScript(virtualMachine: vm, input: inhdl, output: outhdl, error: errhdl, statements: modstmts, arguments: arguments, environment: env, config: compconf)
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
			result = checkFiles(files: files)
		}
	default:
		/* Accept multiple js files */
		result = checkFiles(files: files)
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

private func checkFiles(files fls: Array<String>) -> Package {
	/* Check extensions */
	for f in fls {
		let path = NSString(string: f)
		if path.pathExtension != "js" {
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
	if let libnum = res.countOfLibraryScripts() {
		for i in 0..<libnum {
			if let scr = res.loadLibraryScript(index: i) {
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
	var result: Array<String>? = nil
	let processor = KHShellProcessor()
	switch processor.convert(statements: stmts) {
	case .finished(let newstmts):
		result = newstmts
	case .error(let err):
		cons.error(string: "[Error] \(err.descriotion())\n")
	}
	return result
}

private func executeShell(virtualMachine vm: JSVirtualMachine, input inhdl: FileHandle, output outhdl: FileHandle, error errhdl: FileHandle, scriptFiles files: Array<String>, environment env: CNShellEnvironment, config conf: KHConfig) -> Int32
{
	let shell = KHShellThread(virtualMachine: vm, input: inhdl, output: outhdl, error: errhdl, environment: env, config: conf)
	shell.start()

	sleep(10)

	/* Wait until finished */
	while shell.isExecuting {

	}
	return shell.terminationStatus
}

private func executeScript(virtualMachine vm: JSVirtualMachine, input inhdl: FileHandle, output outhdl: FileHandle, error errhdl: FileHandle, statements stmts: Array<String>, arguments args: Array<String>, environment env: CNShellEnvironment, config conf: KHConfig) -> Int32
{
	let thread  = KHScriptThread(virtualMachine: vm, input: inhdl, output: outhdl, error: errhdl, environment: env, config: conf)
	thread.start(statements: stmts, arguments: args)
	thread.waitUntilExit()
	return 0
}

