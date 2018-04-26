/**
 * @file	JRConfig.swift
 * @brief	Define JRConfig class
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import CoconutData
import Cobalt
import KiwiLibrary
import Foundation

public class JRConfig
{
	public enum Command {
		case NoCommand
		case DumpCommand
	}

	public var command: Command

	public init(command cmd: Command){
		command = cmd
	}

	public class func decodeCommand(command cmd: String) -> Command? {
		var result: Command?
		switch cmd {
		case "dump":
			result = .DumpCommand
		default:
			result = nil
		}
		return result
	}
}

public class JRCommandLineParser
{
	private var mConsole:	CNConsole

	private enum DefaultOptionId: Int {
		case Help	= 0
		case Version	= 1
	}

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func printUsage() {
		mConsole.print(string: "usage: jsadb sub-command [options] [file ...] (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: jsadb [command] [options]\n" +
			"  [command] dump       : Dump content of AddressBook\n" +
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
		let (err, command, rets) = CBParseArguments(parserConfig: parserConfig(), arguments: args)
		if let e = err {
			mConsole.error(string: "Error: \(e.description)\n")
		} else {
			config = parseArguments(command: command, arguments: rets)
		}
		return config
	}

	private func parserConfig() -> CBParserConfig {
		let deftypes: Array<CBOptionType> = [
			CBOptionType(optionId: DefaultOptionId.Help.rawValue,
				     shortName: "h", longName: "help",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Print help message and exit program"),
			CBOptionType(optionId: DefaultOptionId.Version.rawValue,
				     shortName: nil, longName: "version",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Print version information"),
		]
		let config = CBParserConfig(hasSubCommand: true)
		config.setDefaultOptions(optionTypes: deftypes)
		return config
	}

	private func parseArguments(command cmdstr: String?, arguments args: Array<CBArgument>) -> JRConfig? {
		/* Parse command */
		let command: JRConfig.Command
		if let cstr = cmdstr {
			if let cmd = JRConfig.decodeCommand(command: cstr) {
				command = cmd
			} else {
				mConsole.error(string: "Unknown command: \(cstr)\n")
				return nil
			}
		} else {
			command = .NoCommand
		}

		let config = JRConfig(command: command)

		/* Parse options */
		let stream = CNArrayStream(source: args)
		while let arg = stream.get() {
			if let opt = arg as? CBOptionArgument {
				if !parseOption(config: config, command: command, option: opt) {
					return nil
				}
			} else if let norm = arg as? CBNormalArgument {
				if !parseNormal(config: config, command: command, normal: norm) {
					return nil
				}
			} else {
				NSLog("Unknown kind of argument")
			}
		}
		return config
	}

	private func parseOption(config conf: JRConfig, command cmd: JRConfig.Command, option opt: CBOptionArgument) -> Bool {
		var result: Bool
		switch cmd {
		case .NoCommand:
			if let optid = DefaultOptionId(rawValue: opt.optionType.optionId) {
				switch optid {
				case .Help:
					printHelpMessage()
					result = false
				case .Version:
					printVersionMessage()
					result = false
				}
			} else {
				NSLog("Unknown option id")
				result = false
			}
		case .DumpCommand:
			NSLog("Dump command has no options")
			result = false
		}
		return result
	}

	private func parseNormal(config conf: JRConfig, command cmd: JRConfig.Command, normal norm: CBNormalArgument) -> Bool {
		mConsole.error(string: "This command does not require argument\n")
		return false
	}
}
