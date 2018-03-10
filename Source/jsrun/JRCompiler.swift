/**
 * @file	JRCompiler.swift
 * @brief	Define JRCompiler class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import KiwiEngine
import KiwiLibrary
import JavaScriptCore
import Foundation

public class JRCompiler
{
	private var mContext:		KEContext
	private var mExceptionHandler:	(_ exception: KEException) -> Void

	public init(context ctxt: KEContext, exceptionHandler ehandler: @escaping (_ exception: KEException) -> Void){
		mContext 		= ctxt
		mExceptionHandler	= ehandler
	}

	public func compile(config cfg: JRConfig) -> CompileError {
		do {
			/* compile user script */
			for file in cfg.scriptFiles {
				let script = try readScript(scriptFile: file)
				mContext.runScript(script: script, exceptionHandler: {
					(_ result: KEException) -> Void in
					self.mExceptionHandler(result)
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

	public func callMainFunction(arguments args: Array<String>) {
		mContext.callFunction(functionName: "main", arguments: [args], exceptionHandler: mExceptionHandler)
	}
}
