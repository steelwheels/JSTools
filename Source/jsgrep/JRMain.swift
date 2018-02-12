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
	guard let config = parser.parseArguments(arguments: Array(args.dropFirst())) else {
		return 1
	}

	/* Read input file */
	var srcinfo: NSDictionary
	if let infile = openInputFile(config: config, console: console) {
		if let info = unserializeString(file: infile, console: console){
			srcinfo = info
		} else {
			return 2
		}
	} else {
		return 2
	}

	return 0
}

private func openInputFile(config conf: JRConfig, console cons: CNConsole) -> CNFile?
{
	var result: CNFile?
	if let inname = conf.inputFileName {
		result = openFile(fileName: inname, console: cons)
	} else {
		result = CNStandardFile(type: .input)
	}
	return result
}

private func openFile(fileName name: String, console cons: CNConsole) -> CNFile?
{
	var result: CNFile?
	let (file, err) = CNOpenFile(filePath: name, accessType: .ReadAccess)
	if  let f = file {
		result = f
	} else {
		let errstr = err!.toString()
		cons.error(string: "[Error] \(errstr)\n")
		result = nil
	}
	return result
}

private func unserializeString(file f: CNFile, console cons: CNConsole) -> NSDictionary?
{
	var result: NSDictionary? = nil
	if let content = f.getAll() {
		let (jdata, err) = CNJSONFile.unserialize(string: content)
		if let d = jdata {
			result = d
		} else {
			let errstr = err!.toString()
			cons.error(string: "[Error] \(errstr)\n")
		}
	}
	return result
}

