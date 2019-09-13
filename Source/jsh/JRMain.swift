/**
 * @file	JRMain.swift
 * @brief	Define main function for JSH
 * @par Copyright
 *   Copyright (C) 2019 Steel Wheels Project
 */

import CoconutData
import CoconutShell
import KiwiShell
import KiwiEngine
import JavaScriptCore
import Foundation

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
		/* Read files */
		guard let stmts = readFiles(fileNames: files, console: console) else {
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

private func readFiles(fileNames files: Array<String>, console cons: CNConsole) -> Array<String>? {
	var stmts: Array<String> = []
	for file in files {
		let url = URL(fileURLWithPath: file)
		let (scr, err) = url.loadContents()
		if let scr = scr {
			/* Split by newline */
			let sstmts = scr.components(separatedBy: "\n")
			stmts.append(contentsOf: sstmts)
		} else {
			if let err = err {
				cons.error(string: "[Error] \(err.description)\n")
			} else {
				cons.error(string: "[Error] Unknown error\n")
			}
			return nil
		}
	}
	return stmts
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

