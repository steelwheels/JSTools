/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import Foundation

public func main(arguments args: Array<String>) -> Int32
{
	let console = CNFileConsole()

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let config = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	/* Open first file */
	var firstinfo: Dictionary<String, Any>
	if let firstfile = openFirstFile(config: config, console: console) {
		if let info = unserializeString(file: firstfile, console: console){
			firstinfo = info
		} else {
			return 2
		}
	} else {
		return 2
	}

	/* Merge other files */
	let infiles = config.inputFiles
	if infiles.count > 1 {
		for i in 1..<infiles.count {
			if let file = openFile(fileName: infiles[i], console: console) {
				if let info = unserializeString(file: file, console: console){
					/* Merge file */
					CNJSON.merge(destination: &firstinfo, source: info)
				} else {
					return 2
				}
			} else {
				return 2
			}
		}
	}

	/* output merged file */
	let (text, err) = CNJSONFile.serialize(dictionary: firstinfo)
	if let t = text {
		let out = CNStandardFile(type: .output)
		let _ = out.put(string: t)
		let _ = out.put(string: "\n")	// Add last new line
		return 0
	} else {
		let errstr = err!.toString()
		console.error(string: "[Error] \(errstr)\n")
		return 2
	}
}

private func openFirstFile(config conf: JRConfig, console cons: CNConsole) -> CNFile?
{
	var result: CNFile?
	let infiles = conf.inputFiles
	if infiles.count >= 1 {
		result = openFile(fileName: infiles[0], console: cons)
	} else {
		/* Read standard input */
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

private func unserializeString(file f: CNFile, console cons: CNConsole) -> Dictionary<String, Any>?
{
	var result: Dictionary<String, Any>? = nil
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


