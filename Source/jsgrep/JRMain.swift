/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import Canary
import Foundation

private let appname = "jsgrep"

public func main(arguments args: Array<String>) -> Int32
{
	let console = CNFileConsole()

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let _ = parser.parseArguments(arguments: Array(args.dropFirst())) else {
		return 1
	}

	return 0
}

