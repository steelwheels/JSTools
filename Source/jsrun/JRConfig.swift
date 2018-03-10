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
	public var isInteractiveMode:	Bool	      = false
	public var doUseMain:		Bool	      = false
	public var arguments:		Array<String> = []
}

public class JRCommandLineParser
{
	private var mConsole:	CNConsole

	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
		case NoStrictMode	= 2
		case InteractiveMode	= 3
		case UseMain		= 4
		case Argument		= 5
	}

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func parserConfig() -> CBParserConfig {
		let opttypes: Array<CBOptionType> = [
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
			CBOptionType(optionId: OptionId.InteractiveMode.rawValue,
				     shortName: "i", longName: "interactive",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Activate interactive mode"),
			CBOptionType(optionId: OptionId.UseMain.rawValue,
				     shortName: nil, longName: "use-main",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Use \"main\" function"),
			CBOptionType(optionId: OptionId.Argument.rawValue,
				     shortName: "a", longName: "argument",
				     parameterNum: 1, parameterType: .StringType,
				     helpInfo: "Argument(s) passed to JavaScript code")
		]
		let config = CBParserConfig(hasSubCommand: false)
		config.setDefaultOptions(optionTypes: opttypes)
		return config
	}

	private func printUsage() {
		mConsole.print(string: "usage: jsrunner [options] script-file1 ... (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: jsrunner [options] script-file1 script-file2 ...\n" +
		"  [options]\n" +
		"    --help, -h             : Print this message\n" +
		"    --version              : Print version\n" +
		"    --no-strict            : Do not use strict mode (default: use strict)\n" +
		"    --use-main             : Call \"main\" function after compilation\n" +
		"    --interactive, -i      : Activate interactive mode\n" +
		"    --argument -a <string> : String to be passed as an argument\n"
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
		let (err, _, rets) = CBParseArguments(parserConfig: parserConfig(), arguments: args)
		if let e = err {
			mConsole.error(string: "Error: \(e.description)\n")
		} else {
			config = parseOptions(arguments: rets)
		}
		return config
	}

	private func parseOptions(arguments args: Array<CBArgument>) -> JRConfig? {
		let config   = JRConfig()
		var argstr = ""
		let stream   = CNArrayStream(source: args)
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
					case .InteractiveMode:
						config.isInteractiveMode = true
					case .UseMain:
						config.doUseMain = true
					case .Argument:
						for param in opt.parameters {
							if let str = param.stringValue {
								argstr += str + " "
							} else {
								NSLog("Invalid value: \(param.description)")
								return nil
							}
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
		/* Get arguments */
		config.arguments = CNStringUtil.divideByQuote(sourceString: argstr, quote: "\"")

		if config.isInteractiveMode || config.scriptFiles.count > 0 {
			return config
		} else {
			mConsole.error(string: "No script files are given\n")
			printUsage()
			return nil
		}
	}
}
