/**
 * @file	JSHMain.swift
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

	let compconf = KHConfig(applicationType: .terminal, hasMainFunction: config.doUseMain, doStrict: config.doStrict, logLevel: config.logLevel)

	/* Prepare environment variable */
	let environment = CNEnvironment()

	/* Prepare process manager */
	let procmgr = CNProcessManager()

	let files = config.scriptFiles
	if files.count == 0 || config.isInteractiveMode {
		/* Execute shell */
		let emptyres = KEResource(baseURL: Bundle.main.bundleURL)
		return executeShell(processManager: procmgr, input: instrm, output: outstrm, error: errstrm, scriptFiles: files, environment: environment, resource: emptyres, config: compconf)
	} else if files.count == 1 {
		/* Get source file */
		let fileurl = URL(fileURLWithPath: files[0])
		let srcfile: KEResource
		switch KEResource.allocateResource(from: fileurl) {
		case .ok(let res):
			srcfile = res
		case .error(let err):
			console.error(string: "[Error] \(err.description)\n")
			return 1
		@unknown default:
			console.error(string: "[Error] Unknown allocation result\n")
			return 1
		}
		if let stmts = readMainScript(sourceFile: srcfile) {
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
				/* Allocate script */
				let modscr = modstmts.joined(separator: "\n")
				srcfile.storeApplication(script: modscr)
				/* Execute script */
				return executeScript(resource: srcfile, processManager: procmgr, input: instrm, output: outstrm, error: errstrm, script: modscr, arguments: arguments, environment: environment, config: compconf)
			}
		} else {
			console.error(string: "[Error] Failed to read \(files[0])\n")
		}
	} else {
		console.error(string: "[Error] Too many source files\n")
	}
	return 1
}

private func readMainScript(sourceFile file: KEResource) -> Array<String>? {
	if let script = file.loadApplication() {
		return script.components(separatedBy: "\n")
	} else {
		return nil
	}
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
	@unknown default:
		cons.error(string: "[Error] Unknown parse result\n")
		result = nil
	}
	return result
}

private func executeShell(processManager procmgr: CNProcessManager, input instrm: CNFileStream, output outstrm: CNFileStream, error errstrm: CNFileStream, scriptFiles files: Array<String>, environment env: CNEnvironment, resource res: KEResource, config conf: KHConfig) -> Int32
{
	let shell = KHShellThread(processManager: procmgr, input: instrm, output: outstrm, error: errstrm, environment: env, config: conf)
	shell.start(argument: .nullValue)
	while !shell.status.isRunning {
		/* wait until exit */
	}
	return shell.terminationStatus
}

private func executeScript(resource res: KEResource, processManager procmgr: CNProcessManager, input instrm: CNFileStream, output outstrm: CNFileStream, error errstrm: CNFileStream, script scr: String, arguments args: Array<String>, environment env: CNEnvironment, config conf: KHConfig) -> Int32
{
	let thread  = KHScriptThread(source: .application(res), processManager: procmgr, input: instrm, output: outstrm, error: errstrm, environment: env, config: conf)

	/* Convert argument */
	var nargs: Array<CNNativeValue> = []
	for arg in args {
		nargs.append(.stringValue(arg))
	}
	thread.start(argument: .arrayValue(nargs))
	while !thread.status.isRunning {
		/* wait until exit */
	}
	return thread.terminationStatus
}

