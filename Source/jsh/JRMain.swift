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
		/* Execute script */
		return executeScript(virtualMachine: vm, input: inhdl, output: outhdl, error: errhdl, scriptFiles: files, arguments: arguments, environment: env, config: compconf)
	}
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

private func executeScript(virtualMachine vm: JSVirtualMachine, input inhdl: FileHandle, output outhdl: FileHandle, error errhdl: FileHandle, scriptFiles files: Array<String>, arguments args: Array<String>, environment env: CNShellEnvironment, config conf: KHConfig) -> Int32
{
	/* Get URLs for script */
	var urls: Array<URL> = []
	for file in files {
		urls.append(URL(fileURLWithPath: file))
	}

	let thread  = KHScriptThread(virtualMachine: vm, input: inhdl, output: outhdl, error: errhdl, environment: env, config: conf)
	thread.start(userScripts: urls, arguments: args)
	thread.waitUntilExit()

	return 0
}

