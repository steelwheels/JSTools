/**
 * @file	JRError.swift
 * @brief	Define JRError class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Canary
import Foundation

public enum CompileError: Error {
	case NoError
	case CanNotRead(fileName: String)
	case CompileError(errors: Array<String>, scriptFile: String)

	public func dump(to console: CNConsole){
		switch self {
		case .NoError:
			break
		case .CanNotRead(let name):
			console.error(string: "Error: Can not read file: \(name)\n")
		case .CompileError(let errors, let file):
			for error in errors {
				console.error(string: "\(error) in file \(file)\n")
			}
		}
	}
}

