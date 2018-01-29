/**
 * @file	JRConfig.swift
 * @brief	Define JRConfig class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import Cobalt
import KiwiLibrary
import Foundation

public class JRConfig
{
	public var scriptFiles:		Array<String> = []
	public var libraryConfig:	KLConfig      = KLConfig()
}

public class JRCommandLineParser
{
	private var mConsole:	CNConsole

	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
		case NoStrictMode	= 2
	}

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func optionTypes() -> Array<CBOptionType> {
		return [
			CBOptionType(optionId: OptionId.Help.rawValue,
				     shortName: "h", longName: "help",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Print help message and exit program"),
			CBOptionType(optionId: OptionId.Version.rawValue,
				     shortName: nil, longName: "version",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Print version information"),
			CBOptionType(optionId: OptionId.NoStrictMode.rawValue,
				     shortName: nil, longName: "no-strict",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Do not use strict mode"),
		]
	}

	private func printUsage() {
		mConsole.print(string: "usage: jsrunner [options] script-file1 ... (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: jsrunner [options] script-file1 script-file2 ...\n" +
		"  [options]\n" +
		"    --help, -h  : Print this message\n" +
		"    --version   : Print version\n" +
		"    --no-strict : Do not use strict mode (default: use strict)\n"
		)
	}

	private func printVersionMessage() {
		let plist = CNPropertyList(bundleDirectoryName: "jstools.bundle")
		let version: String
		if let v = plist.version {
			version = v
		} else {
			version = "<Unknown>"
		}
		mConsole.print(string: "\(version)\n")
	}

	public func parseArguments(arguments args: Array<String>) -> JRConfig? {
		var config : JRConfig? = nil
		let (err, rets) = CBParseArguments(optionTypes: optionTypes(), arguments: args)
		if let e = err {
			mConsole.error(string: "Error: \(e.description)\n")
		} else {
			config = parseOptions(arguments: rets)
		}
		return config
	}

	private func parseOptions(arguments args: Array<CBArgument>) -> JRConfig? {
		let config = JRConfig()
		let stream = CNArrayStream(source: args)
		while let arg = stream.get() {
			if let opt = arg as? CBOptionArgument {
				if let optid = OptionId(rawValue: opt.optionType.optionId) {
					switch optid {
					case .Help:
						printHelpMessage()
						return nil
					case .Version:
						printVersionMessage()
						return nil
					case .NoStrictMode:
						config.libraryConfig.useStrictMode = false
					}
				} else {
					NSLog("[Internal error] Unknown option id")
				}
			} else if let param = arg as? CBNormalArgument {
				config.scriptFiles.append(param.argument)
			} else {
				NSLog("[Internal error] Unknown object: \(arg)")
				return nil
			}
		}
		if config.scriptFiles.count > 0 {
			return config
		} else {
			mConsole.error(string: "No script files are given\n")
			printUsage()
			return nil
		}
	}
}
