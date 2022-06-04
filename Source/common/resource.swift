/**
 * @file	resource.swift
 * @brief	Define main function for resource managerment
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import CoconutData
import CoconutDatabase
import CoconutShell
import KiwiEngine
import KiwiLibrary
import JavaScriptCore
import Foundation

public func loadResource(packageDirectory pdir: String, console cons: CNConsole) -> KEResource?
{
	guard let packurl = manifestURL(packageDirectory: pdir, console: cons) else {
		return nil
	}
	let resource = KEResource(packageDirectory: packurl)
	let loader   = KEManifestLoader()
	if let err = loader.load(into: resource) {
		cons.error(string: "[Error] " + err.toString() + "\n")
		return nil
	}
	return resource
}

private func manifestURL(packageDirectory pdir: String, console cons: CNConsole) -> URL? {
	guard FileManager.default.fileExists(atPath: pdir) else {
		cons.error(string: "[Error] No valid package directory\n")
		return nil
	}
	switch FileManager.default.checkFileType(pathString: pdir) {
	case .Directory:
		break // expected
	case .File:
		cons.error(string: "[Error] Package directory is required but the path for the file is given: \"\(pdir)\"\n")
		return nil
	case .NotExist:
		cons.error(string: "[Error] Given package directory is not exist: \"\(pdir)\"\n")
		return nil
	@unknown default:
		cons.error(string: "[Error] Given package directory is not exist: \"\(pdir)\"\n")
		return nil
	}
	return URL(fileURLWithPath: pdir, isDirectory: true)
}

