/**
 * @file	JRCompiler.swift
 * @brief	Define JRCompiler class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import KiwiEngine
import KiwiObject
import KiwiLibrary
import CoconutData
import JavaScriptCore
import Foundation

public class JRCompiler: KLCompiler
{
	private var mConfig:	JRConfig

	public init(console cons: CNConsole, config conf: JRConfig) {
		mConfig = conf
		super.init(console: cons, config: conf)
	}

	public override func compile(context ctxt: KEContext) -> Bool {
		/* Compile library */
		guard super.compile(context: ctxt) else {
			return false
		}
		/* Compile user source */
		do {
			for file in mConfig.scriptFiles {
				let script = try readScript(scriptFile: file)
				ctxt.evaluateScript(script)
			}
			return true
		} catch let err as KEError {
			self.console.error(string: "\(err.description)\n")
			return false
		} catch _ {
			self.console.error(string: "Internal error")
			return false
		}
	}

	private func readScript(scriptFile file: String) throws -> String {
		do {
			let url  = URL(fileURLWithPath: file)
			return try String(contentsOf: url, encoding: .utf8)
		} catch _ {
			throw KEError(canNotReadError: file)
		}
	}
}

