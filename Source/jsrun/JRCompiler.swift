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
	private var mApplication:		KEApplication

	public init(application app: KEApplication){
		mApplication = app
	}

	public func compile(config cfg: JRConfig) -> CompileError {
		do {
			/* compile user script */
			for file in cfg.scriptFiles {
				let script = try readScript(scriptFile: file)
				mApplication.context.runScript(script: script)
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
		mApplication.context.callFunction(functionName: "main", arguments: [args])
	}
}
