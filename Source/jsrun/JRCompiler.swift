/**
 * @file	JRCompiler.swift
 * @brief	Define JRCompiler class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import KiwiEngine
import KiwiLibrary
import Foundation

public class JRCompiler
{
	private var mContext:	KEContext
	private var mConfig:	JRConfig

	public init(context ctxt: KEContext, config cfg: JRConfig){
		mContext = ctxt
		mConfig  = cfg
	}

	public func compile(exceptionHandler ehandler: @escaping (_ exception: KEException) -> Void) -> CompileError {
		do {
			/* compile user script */
			for file in mConfig.scriptFiles {
				let script = try readScript(scriptFile: file)
				mContext.runScript(script: script, exceptionHandler: {
					(_ result: KEException) -> Void in
					ehandler(result)
				})
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
}
