/**
 * @file	Config.swift
 * @brief	Define Config class
 * @par Copyright
 *   Copyright (C) 2020 Steel Wheels Project
 */

import CoconutData
import Cobalt
import KiwiEngine
import KiwiLibrary
import Foundation

public class Config: KEConfig
{
	private var mScriptFiles:		Array<String>

	public var scriptFiles: 	Array<String>	{ get { return mScriptFiles		}}

	public init(scriptFiles files: Array<String>, logLevel level: CNConfig.LogLevel){
		mScriptFiles		= files
		super.init(applicationType: .terminal, doStrict: true, logLevel: level)
	}
}

public class AMBCommandLineParser
{
	private var mConsole:	CNConsole

	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
		case Log		= 2
	}

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func parserConfig() -> CBParserConfig {
		let opttypes: Array<CBOptionType> = [
			CBOptionType(optionId: OptionId.Help.rawValue,
				     shortName: "h", longName: "help",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Print help message and exit program"),
			CBOptionType(optionId: OptionId.Version.rawValue,
				     shortName: nil, longName: "version",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Print version information"),
			CBOptionType(optionId: OptionId.Log.rawValue,
				     shortName: nil, longName: "log",
				     parameterNum: 1, parameterType: .stringType,
				     helpInfo: "Print vebose information for debugging")
		]
		let config = CBParserConfig(hasSubCommand: false)
		config.setDefaultOptions(optionTypes: opttypes)
		return config
	}

	private func printUsage() {
		mConsole.print(string: "usage: amb [options] script-file1 ... (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: amb [options] script-file1 script-file2 ...\n" +
		"  [options]\n" +
		"    --help, -h             : Print this message\n" +
		"    --version              : Print version\n" +
		"    --argument -a <string> : String to be passed as an argument\n" +
		"    --log <string>         : Define debug log level (default: normal)\n"
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

	public func parseArguments(arguments args: Array<String>) -> (Config, Array<String>)? {
		var config : Config? = nil
		let (err, _, rets, subargs) = CBParseArguments(parserConfig: parserConfig(), arguments: args)
		if let e = err {
			mConsole.error(string: "Error: \(e.description)\n")
		} else {
			config = parseOptions(arguments: rets)
		}
		if let config = config {
			return (config, subargs)
		} else {
			return nil
		}
	}

	private func parseOptions(arguments args: Array<CBArgument>) -> Config? {
		let stream   = CNArrayStream(source: args)

		var files:		Array<String>		= []
		var logLevel:		CNConfig.LogLevel	= .defaultLevel

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
					case .Log:
						if let level = decodeLogLevel(parameters: opt.parameters) {
							logLevel = level
						}
					}
				} else {
					NSLog("[Internal error] Unknown option id")
				}
			} else if let param = arg as? CBNormalArgument {
				files.append(param.argument)
			} else {
				NSLog("[Internal error] Unknown object: \(arg)")
				return nil
			}
		}
		return Config(scriptFiles: files, logLevel: logLevel)
	}

	private func decodeLogLevel(parameters params: Array<CBValue>) -> CNConfig.LogLevel? {
		if params.count == 1 {
			let paramstr = params[0].description
			return CNConfig.LogLevel.decode(string: paramstr)
		} else {
			mConsole.error(string: "One parameter for log level is required")
		}
		return nil
	}
}
