/**
 * @file	Config.swift
 * @brief	Define Config class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import CoconutData
import Cobalt
import KiwiEngine
import KiwiLibrary
import Foundation

public class Config: KEConfig
{
	private var mPackageDirectory:	String

	public var packageDirectory: 	String	{ get { return mPackageDirectory		}}

	public init(packageDirectory pkgdir: String){
		mPackageDirectory = pkgdir
		super.init(applicationType: .terminal, doStrict: true, logLevel: .defaultLevel)
	}
}

public class CommandLineParser
{
	private var mConsole:	CNConsole

	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
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
				     helpInfo: "Print version information")
		]
		let config = CBParserConfig(hasSubCommand: false)
		config.setDefaultOptions(optionTypes: opttypes)
		return config
	}

	private func printUsage() {
		mConsole.print(string: "usage: jsstorage [options] package directory (\"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: jsstorage [options] package-directory\n" +
		"  [options]\n" +
		"    --help, -h             : Print this message\n" +
		"    --version              : Print version\n"
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
			mConsole.error(string: "[Error] \(e.description)\n")
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

		var pkgdir: String? = nil

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
					}
				} else {
					mConsole.error(string: "[Error] Unknown command line option ids\n")
				}
			} else if let param = arg as? CBNormalArgument {
				if pkgdir == nil {
					pkgdir = param.argument
				} else {
					mConsole.error(string: "[Error] Too many parameters are given\n")
				}
			} else {
				mConsole.error(string: "[Error] Unknown command line parameter: \(arg)\n")
				return nil
			}
		}
		if let dir = pkgdir {
			return Config(packageDirectory: dir)
		} else {
			mConsole.error(string: "[Error] parameter for package directory is required\n")
			return nil
		}
	}
}
