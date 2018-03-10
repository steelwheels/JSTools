/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import KiwiEngine
import KiwiShell
import KiwiLibrary
import JavaScriptCore
import Foundation

public func main(arguments args: Array<String>) -> Int32
{
	let filecons = CNFileConsole()
	let curscons = CNCursesConsole(defaultConsole: filecons)

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: filecons)
	guard let config = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	/* allocate context */
	let context = KEContext(virtualMachine: JSVirtualMachine())

	/* set exception handler */
	let ehandler = {
		(_ exception: KEException) -> Void in
		/* Finalize */
		JRFinalize.finalize(console: curscons)
		/* Exit */
		switch exception {
		case .CompileError(let message):
			curscons.error(string: message + "\n")
			Darwin.exit(1)
		case .Evaluated(_, _):
			//NSLog("\(exception.description)")
			break
		case .Exit(let code):
			Darwin.exit(code)
		case .Terminated(_, let message):
			curscons.error(string: message + "\n")
			Darwin.exit(1)
		}
	}

	/* setup built-in library */
	let jsargs  = config.arguments
	let libconf = config.libraryConfig
	KLSetupLibrary(context: context, arguments: jsargs, console: curscons, config: libconf, exceptionHandler: ehandler)

	/* Compile scripts */
	let compiler = JRCompiler(context: context, exceptionHandler: ehandler)
	let error    = compiler.compile(config: config)

	/* Call main function when "--use-main" option is given */
	if config.doUseMain {
		compiler.callMainFunction(arguments: jsargs)
	}
	
	/* Finalize */
	JRFinalize.finalize(console: curscons)
	switch error {
	case .NoError:
		break
	default:
		error.dump(to: curscons)
		return 2
	}

	/* Enter interative mode */
	var exitcode: Int32 = 0
	if config.isInteractiveMode {
		/* Execute shell mode */
		let appname = args[0]
		let shell   = KHShellConsole(applicationName: appname, context: context, console: filecons)
		exitcode = shell.repl()
	}

	return exitcode
}

