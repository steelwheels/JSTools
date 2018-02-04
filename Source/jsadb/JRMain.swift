/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import Canary
import Foundation

public func main(arguments args: Array<String>) -> Int32
{
	let console = CNFileConsole()

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let config = parser.parseArguments(arguments: Array(args.dropFirst())) else {
		return 1
	}

	switch config.command {
	case .DumpCommand:
		console.print(string: "Dump")
	case .NoCommand:
		break /* Do nothing */
	}

	return 0 // no error
}

