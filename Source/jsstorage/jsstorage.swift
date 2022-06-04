/**
 * @file	jsstorage_main.swift
 * @brief	Define main function for jsstorage
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import Foundation

public func jsstorage_main(arguments args: Array<String>) -> Int32
{
	/* Parse command line arguments */
	let stdfile = CNStandardFiles.shared
	let console = CNFileConsole(input: stdfile.input, output: stdfile.output, error: stdfile.error)
	let parser  = CommandLineParser(console: console)
	guard let (config, _) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return -1
	}

	/* Get resource */
	guard let resource = loadResource(packageDirectory: config.packageDirectory, console: console) else {
		return -1
	}

	/* dump storages */
	if let idents = resource.identifiersOfStorage() {
		for ident in idents {
			if let storage = resource.loadStorage(identifier: ident) {
				switch storage.load() {
				case .success(_):
					/* dump root value */
					console.log(string: "// storage: \(ident)\n")
					dump(value: storage.toValue(), console: console)
					let segs = storage.segments(traceOption: .traceAll)
					for seg in segs {
						console.log(string: "// segment: \(seg.cacheFile.path)\n")
						if let val = seg.context {
							dump(value: val.toValue(), console: console)
						} else {
							console.error(string: "Failed to load\n")
						}
					}
				case .failure(let err):
					console.error(string: err.toString() + "\n")
					return -1
				}
			} else {
				console.error(string: "Failed to load storage: \"\(ident)\"\n")
				return -1
			}
		}
	}

	return 0
}

private func dump(value val: CNValue, console cons: CNConsole) {
	let txt = val.toText().toStrings().joined(separator: "\n")
	cons.print(string: txt)
	cons.print(string: "\n")
}
