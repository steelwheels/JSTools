/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import Foundation

public func main(arguments args: Array<String>) -> Int32
{
	let console = CNFileConsole()

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let (config, _) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	/* Open first file */
	let inname: String? = config.inputFiles.count > 0 ? config.inputFiles[0] : nil
	guard var firstinfo = readFile(fileName: inname, console: console) else {
		return 2
	}

	/* Merge other files */
	let infiles = config.inputFiles
	if infiles.count > 1 {
		let merger = CNNativeValueMerger()
		for i in 1..<infiles.count {
			if let file = openFile(fileName: infiles[i], console: console) {
				let (infop, error) = CNJSONFile.readFile(file: file)
				if let info = infop {
					if let resinfo = merger.merge(firstinfo, info) {
						firstinfo = resinfo
					}
				} else {
					console.error(string: "[Error] \(error!.description)")
					return 2
				}
			} else {
				return 2
			}
		}
	}

	/* output merged file */
	let outfile = CNTextFileObject(fileHandle: FileHandle.standardOutput)
	if let err = CNJSONFile.writeFile(file: outfile, JSONObject: firstinfo) {
		console.error(string: "[Error] \(err.description)")
		return 2
	} else {
		return 0
	}
}

public func readFile(fileName name: String?, console cons: CNConsole) -> CNNativeValue?
{
	if let file = openFile(fileName: name, console: cons) {
		let (json, error) = CNJSONFile.readFile(file: file)
		if let val = json {
			return val
		} else {
			cons.error(string: "[Error] \(error!.description)\n")
			return nil
		}
	} else {
		return nil
	}
}

private func openFile(fileName name: String?, console cons: CNConsole) -> CNFile?
{
	var result: CNTextFile?
	if let nm = name {
		let (file, err) = CNOpenFile(filePath: nm, accessType: .ReadAccess)
		if  let f = file {
			result = f
		} else {
			let errstr = err!.toString()
			cons.error(string: "[Error] \(errstr)\n")
			result = nil
		}
	} else {
		result = CNTextFileObject(fileHandle: FileHandle.standardInput)
	}
	return result
}

/*
private func openFirstFile(config conf: JRConfig, console cons: CNConsole) -> CNTextFile?
{
	var result: CNTextFile?
	let infiles = conf.inputFiles
	if infiles.count >= 1 {
		result = openFile(fileName: infiles[0], console: cons)
	} else {
		/* Read standard input */
		result = CNStandardFile(type: .input)
	}
	return result
}

private func openFile(fileName name: String, console cons: CNConsole) -> CNTextFile?
{
	var result: CNTextFile?
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

private func unserializeString(file f: CNTextFile, console cons: CNConsole) -> CNJSONObject?
{
	var result: CNJSONObject? = nil
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
*/


