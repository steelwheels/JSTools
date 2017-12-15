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

public func main(arguments args: Array<String>) -> Int
{
	let console = CNFileConsole()

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let config = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	/* allocate context */
	let context = KEContext(virtualMachine: JSVirtualMachine())

	/* setup built-in library */
	KLSetupLibrary(context: context, console: console, config: config.libraryConfig)
	
	/* Compile scripts */
	let compiler = JRCompiler(context: context, config: config)
	let error    = compiler.compile()
	switch error {
	case .NoError:
		break
	default:
		error.dump(to: console)
		return 2
	}

	console.print(string: "Hello, world !!\n")

	return 0
}

