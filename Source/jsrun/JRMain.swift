/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import KiwiEngine
import KiwiLibrary
import JavaScriptCore
import Foundation

public func main(arguments args: Array<String>) -> Int32
{
	let filecons = CNFileConsole()
	let console  = CNCursesConsole(defaultConsole: filecons)

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let config = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	/* allocate context */
	let context = KEContext(virtualMachine: JSVirtualMachine())

	/* set exception handler */
	let ehandler = {
		(_ exception: KEException) -> Void in
		/* Finalize */
		JRFinalize.finalize(console: console)
		/* Exit */
		switch exception {
		case .CompileError(let message):
			console.error(string: message + "\n")
			Darwin.exit(1)
		case .Evaluated(_, _):
			//NSLog("\(exception.description)")
			break
		case .Exit(let code):
			Darwin.exit(code)
		case .Terminated(_, let message):
			console.error(string: message + "\n")
			Darwin.exit(1)
		}
	}

	/* setup built-in library */
	KLSetupLibrary(context: context, console: console, config: config.libraryConfig, exceptionHandler: ehandler)
	
	/* Compile scripts */
	let compiler = JRCompiler(context: context, config: config)
	let error    = compiler.compile(exceptionHandler: ehandler)
	switch error {
	case .NoError:
		break
	default:
		error.dump(to: console)
		return 2
	}

	/* Finalize */
	JRFinalize.finalize(console: console)

	return 0
}

