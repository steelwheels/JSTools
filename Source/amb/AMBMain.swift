/**
 * @file	AMBMain.swift
 * @brief	Define main function for amb
 * @par Copyright
 *   Copyright (C) 2020 Steel Wheels Project
 */

import Amber
import KiwiEngine
import CoconutData
import Foundation

public func main(arguments args: Array<String>) -> Int32
{
	let console = CNFileConsole()

	/* Parse options */
	let parser  = AMBCommandLineParser(console: console)
	guard let (config, _) = parser.parseArguments(arguments: Array(args.dropFirst())) else { // drop application name
		return 1
	}

	/* Get URL of source file */
	guard let source = getSource(config: config, console: console) else {
		return 1
	}

	/* Execute the script */
	let ecode = execute(source: source, config: config, console: console)

	if config.logLevel == .detail {
		console.print(string: "exit-code: \(ecode)\n")
	}
	return ecode
}

private func getSource(config conf: Config, console cons: CNConsole) -> URL? {
	if conf.scriptFiles.count > 0 {
		let file = conf.scriptFiles[0]
		if FileManager.default.isReadableFile(atPath: file) {
			let url = URL(fileURLWithPath: file)
			if conf.logLevel == .detail {
				cons.print(string: "source file: \"\(url.absoluteString)\"\n")
			}
			return url
		} else {
			cons.error(string: "[Error] Can not read source file: \"\(file)\"\n")
		}
	} else {
		cons.error(string: "[Error] No source file\n")
	}
	return nil
}

private func execute(source src: URL, config conf: KEConfig, console cons: CNFileConsole) -> Int32 {
	let instrm:  CNFileStream	= .fileHandle(cons.inputHandle)
	let outstrm: CNFileStream	= .fileHandle(cons.outputHandle)
	let errstrm: CNFileStream	= .fileHandle(cons.errorHandle)
	let pmgr			= CNProcessManager()
	let env				= CNEnvironment()

	let thread = AMBThread(source: .script(src), processManager: pmgr, input: instrm, output: outstrm, error: errstrm, environment: env, config: conf)
	thread.start(argument: .nullValue)

	while !thread.status.isRunning {
		/* wait until exit */
	}
	let ecode = thread.terminationStatus

	let retval = thread.returnValue
	if let retstr = retval.toString() {
		cons.print(string: retstr + "\n")
	}

	return ecode
}
