/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import KiwiShell
import KiwiLibrary
import JavaScriptCore
import Foundation

public func main(arguments args: Array<String>) -> CNExitCode
{
	/* allocate application */
	let application = KEApplication(kind: .Terminal)
	let console     = application.console

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let (config, subargs) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return .CommandLineError
	}

	/* set exception handler */
	application.context.exceptionCallback = {
		(_ exception: KEException) -> Void in

		/* If some error occured, return to console mode */
		let console = application.console
		switch exception {
		case .Evaluated(_, _):
			break
		case .CompileError(_),
		     .Exit(_),
		     .Terminated(_, _):
			/* Finalize */
			finalize(console: console)
		}

		/* Exit when some error occured */
		switch exception {
		case .CompileError(let message):
			console.error(string: message + "\n")
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
			console.error(string: message + "\n")
			let exitcode:CNExitCode = .Exception
			Darwin.exit(exitcode.rawValue)
		}
	}
	
	/* compile library */
	let libcomp = KLLibraryCompiler(application: application)
	libcomp.compile(config: config)
	
	/* Compile scripts */
	let compiler = JRCompiler(application: application)
	let error    = compiler.compile(config: config, arguments: subargs)

	switch error {
	case .NoError:
		/* Call main function when "--use-main" option is given */
		if config.doUseMain {
			let args: Array<String>
			if let a = application.arguments as? Array<String> {
				args = a
			} else {
				args = []
			}
			compiler.callMainFunction(arguments: args)
		}
	case .CanNotRead(_), .CompileError(_, _):
		/* Print error */
		error.dump(to: console)
		/* Exit code */
		let exitcode:CNExitCode = .SyntaxError
		Darwin.exit(exitcode.rawValue)
	}

	/* Finalize */
	finalize(console: console)

	/* Enter interative mode */
	var exitcode: CNExitCode = .NoError
	if config.isInteractiveMode {
		/* Execute shell mode */
		let shell   = KHShellConsole(application: application)
		let code = shell.repl()
		if code != 0 {
			exitcode = .SyntaxError
		}
	}

	return exitcode
}

private func finalize(console cons: CNConsole)
{
	/* do nothing */
}

