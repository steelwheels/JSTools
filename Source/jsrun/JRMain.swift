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

public func main(arguments args: Array<String>) -> CNExitCode
{
	let filecons = CNFileConsole()
	let curscons = CNCursesConsole(defaultConsole: filecons)

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: filecons)
	guard let config = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return .CommandLineError
	}

	/* allocate context */
	let context = KEContext(virtualMachine: JSVirtualMachine())

	/* set exception handler */
	let ehandler = {
		(_ exception: KEException) -> Void in

		/* If some error occured, return to console mode */
		switch exception {
		case .Evaluated(_, _):
			break
		case .CompileError(_),
		     .Exit(_),
		     .Terminated(_, _):
			/* Finalize */
			JRFinalize.finalize(console: curscons)
		}

		/* Exit when some error occured */
		switch exception {
		case .CompileError(let message):
			curscons.error(string: message + "\n")
			let exitcode:CNExitCode = .SyntaxError
			Darwin.exit(exitcode.rawValue)
		case .Evaluated(_, _):
			break // continue processing
		case .Exit(let code):
			if code != 0 {
				let exitcode:CNExitCode = .ExecError
				Darwin.exit(exitcode.rawValue)
			}
		case .Terminated(_, let message):
			curscons.error(string: message + "\n")
			let exitcode:CNExitCode = .Exception
			Darwin.exit(exitcode.rawValue)
		}
	}
	
	/* setup built-in library */
	let jsargs  = config.arguments
	let libconf = config.libraryConfig
	KLSetupLibrary(context: context, arguments: jsargs, console: curscons, config: libconf, exceptionHandler: ehandler)
	
	/* Compile scripts */
	let compiler = JRCompiler(context: context, exceptionHandler: ehandler)
	let error    = compiler.compile(config: config)

	switch error {
	case .NoError:
		/* Call main function when "--use-main" option is given */
		if config.doUseMain {
			compiler.callMainFunction(arguments: jsargs)
		}
	case .CanNotRead(_), .CompileError(_, _):
		/* Print error */
		error.dump(to: curscons)
		/* Exit code */
		let exitcode:CNExitCode = .SyntaxError
		Darwin.exit(exitcode.rawValue)
	}

	/* Finalize */
	JRFinalize.finalize(console: curscons)

	/* Enter interative mode */
	var exitcode: CNExitCode = .NoError
	if config.isInteractiveMode {
		/* Execute shell mode */
		let appname = args[0]
		let shell   = KHShellConsole(applicationName: appname, context: context, console: filecons)
		let code = shell.repl()
		if code != 0 {
			exitcode = .SyntaxError
		}
	}

	return exitcode
}

