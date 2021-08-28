/**
 * @file	Config.swift
 * @brief	Define Config class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import Cobalt
import KiwiEngine
import KiwiLibrary
import Foundation

public class Config: KEConfig
{
	private var mScriptFiles:		Array<String>
	private var mDoUseMain:			Bool
	private var mIsInteractiveMode:		Bool
	private var mIsCompileMode:		Bool

	public var scriptFiles: 	Array<String>	{ get { return mScriptFiles		}}
	public var doUseMain:		Bool		{ get { return mDoUseMain		}}
	public var isInteractiveMode:	Bool		{ get { return mIsInteractiveMode	}}
	public var isCompileMode:	Bool		{ get { return mIsCompileMode		}}

	public init(scriptFiles files: Array<String>, doStrict strict: Bool, doUseMain usemain: Bool, isInteractiveMode imode: Bool, isCompileMode cmode: Bool, logLevel level: CNConfig.LogLevel){
		mScriptFiles		= files
		mDoUseMain		= usemain
		mIsInteractiveMode	= imode
		mIsCompileMode		= cmode
		super.init(applicationType: .terminal, doStrict: strict, logLevel: level)
	}
}

public class JRCommandLineParser
{
	private var mConsole:	CNConsole

	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
		case Log		= 2
		case NoStrictMode	= 3
		case InteractiveMode	= 4
		case CompileMode	= 5
		case UseMain		= 6
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
				     helpInfo: "Print vebose information for debugging"),
			CBOptionType(optionId: OptionId.NoStrictMode.rawValue,
				     shortName: nil, longName: "no-strict",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Do not use strict mode"),
			CBOptionType(optionId: OptionId.InteractiveMode.rawValue,
				     shortName: "i", longName: "interactive",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Activate interactive mode"),
			CBOptionType(optionId: OptionId.CompileMode.rawValue,
				     shortName: "c", longName: "compile",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Compile only. Do not execute."),
			CBOptionType(optionId: OptionId.UseMain.rawValue,
				     shortName: nil, longName: "use-main",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Use \"main\" function"),
		]
		let config = CBParserConfig(hasSubCommand: false)
		config.setDefaultOptions(optionTypes: opttypes)
		return config
	}

	private func printUsage() {
		mConsole.print(string: "usage: jsh [options] script-file1 ... (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: jsh [options] script-file1 script-file2 ...\n" +
		"  [options]\n" +
		"    --help, -h             : Print this message\n" +
		"    --version              : Print version\n" +
		"    --no-strict            : Do not use strict mode (default: use strict)\n" +
		"    --use-main             : Call \"main\" function after compilation\n" +
		"    --interactive, -i      : Activate interactive mode\n" +
		"    --compile, -c          : Compile only. Do not execute the script\n" +
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
		var doStrict:		Bool			= true
		var doUseMain:		Bool			= false
		var isInteractiveMode:	Bool			= false
		var isCompileMode:	Bool			= false
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
					case .NoStrictMode:
						doStrict  = false
					case .InteractiveMode:
						isInteractiveMode = true
					case .CompileMode:
						isCompileMode = true
					case .UseMain:
						doUseMain = true
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
		return Config(scriptFiles: files, doStrict: doStrict, doUseMain: doUseMain, isInteractiveMode: isInteractiveMode, isCompileMode: isCompileMode, logLevel: logLevel)
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
