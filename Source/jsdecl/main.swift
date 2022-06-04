/**
 * @file boot.swift
 * @brief	Define top function for jsdecl command
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import Foundation
import Darwin

let result = jsdecl_main(arguments: CommandLine.arguments)
exit(result)



