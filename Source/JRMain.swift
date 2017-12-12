/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import Foundation

public func main(arguments args: Array<String>) -> Int
{
	let console = CNFileConsole()

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let _ = parser.parseArguments(arguments: args) else {
		return 1
	}

	console.print(string: "Hello, world !!\n")

	return 0
}

