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
	let stdfile = CNStandardFiles.shared
	let console = CNFileConsole(input: stdfile.input, output: stdfile.output, error: stdfile.error)
	let parser  = JRCommandLineParser(console: console)
	guard let (config, arguments) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	let compconf = KEConfig(applicationType: .terminal, doStrict: config.doStrict, logLevel: config.logLevel)

	/* Prepare environment variable */
	let environment = CNEnvironment()

	/* Prepare process manager */
	let procmgr = CNProcessManager()

	/* Prepare terminal information */
	let terminfo = CNTerminalInfo(width: 80, height: 20)

	let files = config.scriptFiles
	if files.count == 0 || config.isInteractiveMode {
		/* Execute shell */
		let emptyres = KEResource(baseURL: Bundle.main.bundleURL)
		return executeShell(processManager: procmgr, input: console.inputFile, output: console.outputFile, error: console.errorFile, scriptFiles: files, terminalInfo: terminfo, environment: environment, resource: emptyres, config: compconf)
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
			guard let modstmts = convertShellStatements(statements: stmts, environment: environment, console: console) else {
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
				return executeScript(resource: srcfile, processManager: procmgr, input: console.inputFile, output: console.outputFile, error: console.errorFile, script: modscr, arguments: arguments, terminalInfo: terminfo, environment: environment, config: compconf)
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

private func convertShellStatements(statements stmts: Array<String>, environment env: CNEnvironment, console cons: CNConsole) -> Array<String>?
{
	let result: Array<String>?
	let parser = KHShellParser()
	switch parser.parse(lines: stmts, environment: env) {
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

private func executeShell(processManager procmgr: CNProcessManager, input ifile: CNFile, output ofile: CNFile, error efile: CNFile, scriptFiles files: Array<String>, terminalInfo terminfo: CNTerminalInfo, environment env: CNEnvironment, resource res: KEResource, config conf: KEConfig) -> Int32
{
	let shell = KHShellThread(processManager: procmgr, input: ifile, output: ofile, error: efile, terminalInfo: terminfo, environment: env, config: conf)
	shell.start(argument: .nullValue)
	while !shell.status.isRunning {
		/* wait until exit */
	}
	return shell.terminationStatus
}

private func executeScript(resource res: KEResource, processManager procmgr: CNProcessManager, input ifile: CNFile, output ofile: CNFile, error efile: CNFile, script scr: String, arguments args: Array<String>, terminalInfo terminfo: CNTerminalInfo, environment env: CNEnvironment, config conf: KEConfig) -> Int32
{
	let thread  = KHScriptThread(source: .application(res), processManager: procmgr, input: ifile, output: ofile, error: efile, terminalInfo: terminfo, environment: env, config: conf)

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

