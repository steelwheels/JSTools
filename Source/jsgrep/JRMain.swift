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
	var srcinfo: CNJSONObject
	if let infile = openInputFile(config: config, console: console) {
		if let info = unserializeString(file: infile, console: console){
			srcinfo = info
		} else {
			return 2
		}
	} else {
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
		let grep = CNJSONGrep(keyExpression: keyexp, valueExpression: valexp)
		if let newdict = grep.execute(JSONObject: srcinfo) {
			srcinfo = newdict
		} else {
			return 0 // output is empty
		}
	}

	/* write results */
	let (text, err) = CNJSONFile.serialize(JSONObject: srcinfo)
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

private func openInputFile(config conf: JRConfig, console cons: CNConsole) -> CNTextFile?
{
	var result: CNTextFile?
	if let inname = conf.inputFileName {
		result = openFile(fileName: inname, console: cons)
	} else {
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

