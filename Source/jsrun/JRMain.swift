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
			/* Call main function */
			if let mainfunc = context.objectForKeyedSubscript("main") {
				if let retval = mainfunc.call(withArguments: [subargs]) {
					if retval.isNumber {
						let ecode = retval.toInt32()
						exit(ecode)	/* Exit this program */
					}
				} else {
					console.error(string: "[Error] No Return value.\n")
					return .InternalError
				}
			} else {
				console.error(string: "Can not find main function.\n")
				return .SyntaxError
			}
		}
	}

	return .NoError
}


