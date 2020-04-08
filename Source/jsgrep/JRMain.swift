/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import CoconutData
import Foundation

private let appname = "jsgrep"

public func main(arguments args: Array<String>) -> Int32
{
	let console = CNFileConsole()

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let (config, _) = parser.parseArguments(arguments: Array(args.dropFirst())) else {
		return 1
	}

	/* Read input file */
	guard var srcinfo = readFile(fileName: config.inputFileName, console: console) else {
		return 2
	}

	/* grep operation */
	for pat in config.patterns {
		var keyexp:	NSRegularExpression? = nil
		var valexp:	NSRegularExpression? = nil
		switch pat {
		case .Key(let kexp):			keyexp = kexp
		case .Value(let vexp):			valexp = vexp
		case .Property(let kexp, let vexp):	keyexp = kexp ; valexp = vexp
		}
		let matcher = CNNativeValueSelector(nameExpression: keyexp, valueExpression: valexp)
		if let newdict = matcher.select(value: srcinfo) {
			srcinfo = newdict
		} else {
			return 0 // output is empty
		}
	}

	/* write results */
	let outfile = CNTextFile(fileHandle: FileHandle.standardOutput)
	if let err = CNJSONFile.writeFile(fileHandle: outfile.fileHandle, JSONObject: srcinfo) {
		console.error(string: "[Error] \(err.description)")
		return 2
	} else {
		return 0
	}
}

public func readFile(fileName name: String?, console cons: CNConsole) -> CNNativeValue?
{
	if let file = openFile(fileName: name, console: cons) {
		let (json, error) = CNJSONFile.readFile(fileHandle: file.fileHandle)
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

private func openFile(fileName name: String?, console cons: CNConsole) -> CNTextFile?
{
	var result: CNTextFile?
	if let nm = name {
		let fmanager = FileManager.default
		let curdir   = fmanager.currentDirectoryPath
		let path     = fmanager.fullPathURL(relativePath: nm, baseDirectory: curdir)
		switch fmanager.openFile(URL: path, accessType: .ReadAccess) {
		case .ok(let file):
			result = file
		case .error(let err):
			cons.error(string: "[Error] \(err.toString())\n")
			result = nil
		}
	} else {
		result = CNTextFile(fileHandle: FileHandle.standardInput)
	}
	return result
}


