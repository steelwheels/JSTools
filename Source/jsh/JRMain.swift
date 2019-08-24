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
	guard let (options, params) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	/* Prepare context */
	guard let vm = JSVirtualMachine() else {
		console.error(string: "Failed to allocate VM\n")
		return 1
	}
	let context  = KEContext(virtualMachine: vm)
	let config   = KEConfig(kind: .Terminal, doStrict: true, doVerbose: options.doVerbose)
	let env      = CNShellEnvironment()
	let compiler = KHShellCompiler()
	guard compiler.compile(context: context, environment: env, console: console, config: config) else {
		console.error(string: "Internal compile error\n")
		return 1
	}

	if params.count == 0 || options.isInteractiveMode {
		/* Execute shell */
		return execute(context: context, scriptFiles: params, environment: env, console: console, config: config)
	} else {
		/* Execute script */
		return execute(context: context, scriptFiles: params, environment: env, console: console, config: config)
	}
}

private func execute(context ctxt: KEContext, scriptFiles files: Array<String>, environment env: CNShellEnvironment, console cons: CNConsole, config conf: KEConfig) -> Int32
{
	/* Allocate shell interface */
	let intf = CNShellInterface()
	intf.input.setWriter(handler: {
		() -> String? in
		let data = FileHandle.standardInput.availableData
		let str  = String(data: data, encoding: .utf8)
		return str
	})
	intf.output.setReader(handler: {
		(_ str: String) -> Void in
		if let data = str.data(using: .utf8) {
			FileHandle.standardOutput.write(data)
		} else {
			NSLog("Failed to geneeate output")
		}
	})
	intf.error.setReader(handler: {
		(_ str: String) -> Void in
		if let data = str.data(using: .utf8) {
			FileHandle.standardError.write(data)
		} else {
			NSLog("Failed to geneeate output")
		}
	})

	let shell  = KHShell(context: ctxt, shellInterface: intf, environment: env, console: cons, config: conf)
	shell.start()
	sleep(10)

	/* Wait until finished */
	while shell.isExecuting {

	}

	return 0
}

/*



	/* start shell */




	/*
	let intf   = CNShellInterface(input: stdin, output: stdout, error: stderr)

	let console = CNFileConsole()
	console.print(string: "Hello from jsh !!\n")
*/
	return 0
}
*/
