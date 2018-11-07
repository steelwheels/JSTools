/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import KiwiObject
import KiwiShell
import KiwiLibrary
import JavaScriptCore
import Foundation

public func main(arguments args: Array<String>) -> CNExitCode
{
	/* Allocate console */
	let console = CNFileConsole()

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let (config, subargs) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return .CommandLineError
	}

	/* Allocate context */
	let context = KEContext(virtualMachine: JSVirtualMachine())
	context.exceptionCallback = {
		(_ exception: KEException) -> Void in
		console.error(string: "\(exception.description)\n")
		let exitcode:CNExitCode = .Exception
		exit(exitcode.rawValue) // exit the application
	}

	/* Compile */
	let compiler = JRCompiler(console: console, config: config)
	guard compiler.compile(context: context) else {
		return .SyntaxError
	}

	/* Call main function */
	if config.doUseMain {
		if let _ = context.objectForKeyedSubscript("main") {
			/* Define command line arguments */
			if let argval = JSValue(object: subargs, in: context) {
				context.set(name: "_arguments", value: argval)
			} else {
				console.error(string: "Can not define command line arguments")
				return .SyntaxError
			}
			/* Call main function */
			compiler.log(string: "/* Define \"_arguments\" for command line arguments */\n")
			let callscr = "_exec(function(args){ main(args) ;}, _arguments) ;\n"
			if let retval = compiler.compile(context: context, statement: callscr) {
				if retval.isUndefined {
					/* Do not check return value */
					return .NoError
				} else if retval.isNumber {

				}
				return .InternalError
			} else {
				return .ExecError
			}
		}
	}

	return .NoError
}


