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

	public override init() {
		super.init()
	}

	public func compile(context ctxt: KEContext, console cons: CNFileConsole, config conf: JRConfig) -> Bool {
		/* Compile library */
		guard super.compileBase(context: ctxt, console: cons, config: conf) else {
			return false
		}
		/* Compile user source */
		do {
			for file in conf.scriptFiles {
				let script = try readScript(scriptFile: file)
				ctxt.evaluateScript(script)
			}
			return true
		} catch let err as KEError {
			cons.error(string: "\(err.description)\n")
			return false
		} catch _ {
			cons.error(string: "Internal error")
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

