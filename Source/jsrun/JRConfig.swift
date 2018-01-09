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
		case Help	= 0
		case Version	= 1
		case Library	= 2
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
			CBOptionType(optionId: OptionId.Library.rawValue,
				     shortName: nil, longName: "lib",
				     parameterNum: 1, parameterType: .StringType,
				     helpInfo: "Import built-in library")
		]
	}

	private func printUsage() {
		mConsole.print(string: "usage: jsrunner [options] script-file1 ... (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: jsrunner [options] script-file1 script-file2 ...\n" +
		"  [options] --help, -h : Print this message\n" +
		"            --version  : Print version\n"
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
		config.libraryConfig.hasFileLib = true
		config.libraryConfig.hasJSONLib = false
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
					case .Library:
						if !parseLibraryOption(config: config, parameters: opt.parameters){
							return nil
						}
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

	private func parseLibraryOption(config conf: JRConfig, parameters params: Array<CNValue>) -> Bool
	{
		var result: Bool = false
		switch params.count {
		case 0:
			mConsole.error(string: "A library name is required to select library\n")
		case 1:
			let param = params[0]
			switch param.type {
			case .StringType:
				if let pstr = param.stringValue {
					result = parseLibraryOption(config: conf, withName: pstr)
				} else {
					assert(false)
				}
			default:
				let desc = param.description
				mConsole.error(string: "The parameter \"\(desc)\" is NOT suitable as a library name\n")
			}
		default:
			mConsole.error(string: "Too many parameters to select library\n")
		}
		return result
	}

	private func parseLibraryOption(config conf: JRConfig, withName name: String) -> Bool
	{
		var result: Bool = false
		switch name {
		case "JSON":
			conf.libraryConfig.hasJSONLib = true
			result = true
		default:
			mConsole.error(string: "Unknown library name: \"\(name)\"\n")
		}
		return result
	}
}
