/**
 * @file jsdecl_main.swift
 * @brief	Define main function for jsdecl
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import CoconutData
import CoconutDatabase
import CoconutShell
import KiwiEngine
import KiwiLibrary
//import KiwiShell
import JavaScriptCore
import Foundation

public func jsdecl_main(arguments args: Array<String>) -> Int32
{
	/* Parse command line arguments */
	let stdfile = CNStandardFiles.shared
	let console = CNFileConsole(input: stdfile.input, output: stdfile.output, error: stdfile.error)
	let parser  = CommandLineParser(console: console)
	guard let (config, _) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	var etable: CNEnumTable? = nil
	if config.isBuiltinMode {
		etable = CNEnumTable.currentEnumTable()
	} else {
		/* Parse manifest file */
		if let packurl = manifestURL(config: config, console: console) {
			etable = customEnumTable(packageDirectory: packurl, config: config, console: console)
		}
	}

	/* dump for debug */
	if config.logLevel.isIncluded(in: .detail) {
		if let tbl = etable {
			let val: CNValue = .dictionaryValue(tbl.toValue())
			let txt          = val.toText().toStrings().joined(separator: "\n")
			console.error(string: txt + "\n")
		}
	}

	/* dump declaration */
	if let tbl = etable {
		let desc = tbl.toDeclaration()
		let txt  = desc.toStrings().joined(separator: "\n")
		console.print(string: txt)
		console.print(string: "\n")
	}

	return 0
}

private func manifestURL(config conf: Config, console cons: CNConsole) -> URL? {
	let path = conf.packageDirectory
	guard FileManager.default.fileExists(atPath: path) else {
		cons.error(string: "[Error] No valid package directory\n")
		return nil
	}
	switch FileManager.default.checkFileType(pathString: path) {
	case .Directory:
		break // expected
	case .File:
		cons.error(string: "[Error] Package directory is required but the path for the file is given: \"\(path)\"\n")
		return nil
	case .NotExist:
		cons.error(string: "[Error] Given package directory is not exist: \"\(path)\"\n")
		return nil
	@unknown default:
		cons.error(string: "[Error] Given package directory is not exist: \"\(path)\"\n")
		return nil
	}
	return URL(fileURLWithPath: path, isDirectory: true)
}

private func customEnumTable(packageDirectory packurl: URL, config conf: Config, console cons: CNConsole) -> CNEnumTable?
{
	let resource = KEResource(packageDirectory: packurl)
	let loader   = KEManifestLoader()
	if let err = loader.load(into: resource) {
		cons.error(string: "[Error] " + err.toString() + "\n")
		return nil
	}

	/* dump contents of resource */
	if conf.logLevel.isIncluded(in: .detail) {
		let txt = resource.toText().toStrings().joined(separator: "\n")
		cons.print(string: "[Error] " + txt + "\n")
	}

	let result: CNEnumTable?
	switch CNEnumTable.loadFromResource(resource: resource) {
	case .success(let etable):
		result = etable
	case .failure(let err):
		cons.error(string: "[Error] " + err.toString() + "\n")
		result = nil
	}
	return result
}
