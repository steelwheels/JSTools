/**
 * @file	JRCompiler.swift
 * @brief	Define JRCompiler class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import KiwiEngine
import Foundation

public class JRCompiler
{
	private var mContext:	KEContext
	private var mConfig:	JRConfig

	public init(context ctxt: KEContext, config cfg: JRConfig){
		mContext = ctxt
		mConfig  = cfg
	}

	public func compile() -> CompileError {
		do {
			/* compile user script */
			for file in mConfig.scriptFiles {
				let script = try readScript(scriptFile: file)
				try compileScript(scriptText: script, scriptFile: file)
			}
			return .NoError
		} catch let error {
			if let e = error as? CompileError {
				return e
			} else {
				fatalError("Unknown error object")
			}
		}
	}

	private func readScript(scriptFile file: String) throws -> String {
		do {
			let url  = URL(fileURLWithPath: file)
			return try String(contentsOf: url, encoding: .utf8)
		} catch _ {
			throw CompileError.CanNotRead(fileName: file)
		}
	}

	private func compileScript(scriptText script: String, scriptFile file: String) throws {
		let (_, errors) = KEEngine.runScript(context: mContext, script: script)
		if let errors = errors {
			throw CompileError.CompileError(errors: errors, scriptFile: file)
		}
	}
}
