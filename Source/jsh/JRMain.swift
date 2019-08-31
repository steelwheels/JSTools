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
	let console = CNFileConsole()
	let parser  = JRCommandLineParser(console: console)
	guard let (config, _) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
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
		return executeShell(virtualMachine: vm, scriptFiles: files, environment: env, console: console, config: compconf)
	} else {
		/* Execute script */
		return executeScript(virtualMachine: vm, scriptFiles: files, environment: env, console: console, config: compconf)
	}
}

private func executeShell(virtualMachine vm: JSVirtualMachine, scriptFiles files: Array<String>, environment env: CNShellEnvironment, console cons: CNConsole, config conf: KHConfig) -> Int32
{
	/* Allocate shell interface */
	let intf = CNShellInterface()
	intf.connectWithStandardInput()
	intf.connectWithStandardOutput()
	intf.connectWithStandardError()

	let shell = KHShellThread(virtualMachine: vm, shellInterface: intf, environment: env, console: cons, config: conf)
	shell.start()

	sleep(10)

	/* Wait until finished */
	while shell.isExecuting {

	}
	return shell.terminationStatus
}

private func executeScript(virtualMachine vm: JSVirtualMachine, scriptFiles files: Array<String>, environment env: CNShellEnvironment, console cons: CNConsole, config conf: KHConfig) -> Int32
{
	/* Allocate shell interface */
	let intf = CNShellInterface()
	intf.connectWithStandardInput()
	intf.connectWithStandardOutput()
	intf.connectWithStandardError()

	/* Get URLs for script */
	var urls: Array<URL> = []
	for file in files {
		urls.append(URL(fileURLWithPath: file))
	}

	let thread  = KHScriptThread(virtualMachine: vm, shellInterface: intf, environment: env, console: cons, config: conf)
	thread.start(userScripts: urls, arguments: [])
	sleep(10)

	/* Wait until finished */
	while thread.isExecuting {

	}

	return 0
}

