/**
 * @file	JRConfig.swift
 * @brief	Define JRConfig class
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import Canary
import Cobalt
import Foundation

public enum JRMachingPattern {
	case Key(regexp: NSRegularExpression)
	case Value(regexp: NSRegularExpression)
	case Property(keyexp: NSRegularExpression, valexp: NSRegularExpression)
}

public class JRConfig
{
	public var patterns:		Array<JRMachingPattern>
	public var inputFileName:	String?

	public init(){
		patterns	= []
		inputFileName	= nil
	}
}

public class JRCommandLineParser
{
	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
		case KeyExp		= 2
		case ValueExp		= 3
		case PropertyExps	= 4
	}

	private var mConsole: CNConsole

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func printUsage() {
		mConsole.print(string: "usage: jsgrep [options] [file] (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: jsgrep [options] [file]\n" +
			"  [options] --help, -h                   : Print this message\n" +
			"            --version                    : Print version\n" +
			"            --key,      -k regexp        : Pattern to match property key\n" +
			"            --value,    -v regexp        : Pattern to match property value\n" +
			"            --property, -p regexp regexp : Pattern to match property key\n" +
			"                                           and value\n"
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
					case .KeyExp:
						if let exps = parsePatternOption(count: 1, values: opt.parameters) {
							let pat = JRMachingPattern.Key(regexp: exps[0])
							config.patterns.append(pat)
						} else {
							return nil
						}
					case .ValueExp:
						if let exps = parsePatternOption(count: 1, values: opt.parameters) {
							let pat = JRMachingPattern.Value(regexp: exps[0])
							config.patterns.append(pat)
						} else {
							return nil
						}
					case .PropertyExps:
						if let exps = parsePatternOption(count: 2, values: opt.parameters) {
							let pat = JRMachingPattern.Property(keyexp: exps[0], valexp: exps[1])
							config.patterns.append(pat)
						} else {
							return nil
						}
					}
				} else {
					NSLog("[Internal error] Unknown option id")
				}
			} else if let param = arg as? CBNormalArgument {
				if config.inputFileName == nil {
					config.inputFileName = param.argument
				} else {
					mConsole.error(string: "Too many input file names")
					return nil
				}
			} else {
				NSLog("[Internal error] Unknown object: \(arg)")
				return nil
			}
		}
		return config
	}

	private func parsePatternOption(count cnt: Int, values vals: Array<CNValue>) -> Array<NSRegularExpression>? {
		if vals.count == cnt {
			var result: Array<NSRegularExpression> = []
			for val in vals {
				if let valstr = val.stringValue {
					do {
						let exp = try NSRegularExpression(pattern: valstr, options: [])
						result.append(exp)
					} catch {
						mConsole.error(string: "Can not make regular expression from \"\(valstr)\"")
						return nil
					}
				} else {
					mConsole.error(string: "Invalid type for regular expression")
					return nil
				}
			}
			return result
		} else {
			let vcnt = vals.count
			mConsole.error(string: "Unexpected number of parameters (\(cnt) is required but \(vcnt) is given")
			return nil
		}
	}

	private func parserConfig() -> CBParserConfig {
		let deftypes: Array<CBOptionType> = [
			CBOptionType(optionId: OptionId.Help.rawValue,
				     shortName: "h", longName: "help",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Print help message and exit program"),
			CBOptionType(optionId: OptionId.Version.rawValue,
				     shortName: nil, longName: "version",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Print version information"),
			CBOptionType(optionId: OptionId.KeyExp.rawValue,
				     shortName: "k", longName: "key",
				     parameterNum: 1, parameterType: .StringType,
				     helpInfo: "Regular expression to select property key"),
			CBOptionType(optionId: OptionId.ValueExp.rawValue,
				     shortName: "v", longName: "value",
				     parameterNum: 1, parameterType: .StringType,
				     helpInfo: "Regular expression to select property value"),
			CBOptionType(optionId: OptionId.PropertyExps.rawValue,
				     shortName: "p", longName: "property",
				     parameterNum: 2, parameterType: .StringType,
				     helpInfo: "Regular expression to select property key and value")
			]
		let config = CBParserConfig(hasSubCommand: true)
		config.setDefaultOptions(optionTypes: deftypes)
		return config
	}
}


