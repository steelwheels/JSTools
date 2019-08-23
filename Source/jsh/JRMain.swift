/**
 * @file	JRMain.swift
 * @brief	Define main function for JSH
 * @par Copyright
 *   Copyright (C) 2019 Steel Wheels Project
 */

import CoconutData
import CoconutShell
import KiwiShell
import Foundation

public func main(arguments args: Array<String>) -> Int32
{
	let intf = CNShellInterface()

	/* connect with inout */
	intf.input.setWriter(handler: {
		() -> String? in
		let data = FileHandle.standardInput.availableData
		let str  = String(data: data, encoding: .utf8)
		return str
	})
	intf.output.setReader(handler: {
		(_ str: String) -> Void in
		if let data = str.data(using: .utf8) {
			FileHandle.standardOutput.write(data)
		} else {
			NSLog("Failed to geneeate output")
		}
	})
	intf.error.setReader(handler: {
		(_ str: String) -> Void in
		if let data = str.data(using: .utf8) {
			FileHandle.standardError.write(data)
		} else {
			NSLog("Failed to geneeate output")
		}
	})

	/* start shell */
	let shell = KHShell(shellInterface: intf, console: CNFileConsole())
	shell.start()
	sleep(10)

	/* Wait until finished */
	while shell.isExecuting {

	}

	/*
	let intf   = CNShellInterface(input: stdin, output: stdout, error: stderr)

	let console = CNFileConsole()
	console.print(string: "Hello from jsh !!\n")
*/
	return 0
}

