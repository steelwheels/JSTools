/**
 * @file	JRConfig.swift
 * @brief	Define JRConfig class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import Cobalt
import Foundation

public class JRConfig
{
	public var scriptFiles:	Array<String> = []
}

public class JRCommandLineParser
{
	private var mConsole:	CNConsole

	private enum OptionId: Int {
		case Help	= 0
	}

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func optionTypes() -> Array<CBOptionType> {
		return [
			CBOptionType(optionId: OptionId.Help.rawValue,
				     shortName: "h", longName: "help",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Print help message and exit program")
		]
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: jsrunner [options] script-file1 script-file2 ...\n")
	}
	
	public func parseArguments(arguments args: Array<String>) -> JRConfig? {
		var config : JRConfig? = nil
		let (err, rets) = CBParseArguments(optionTypes: optionTypes(), arguments: args)
		if let e = err {
			mConsole.print(string: "Error: \(e.description)\n")
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
					}
				} else {

				}
			} else if let param = arg as? CBNormalArgument {
				config.scriptFiles.append(param.argument)
			} else {
				NSLog("[Internal error] Unknown object: \(arg)")
				return nil
			}
		}
		return config
	}
}
