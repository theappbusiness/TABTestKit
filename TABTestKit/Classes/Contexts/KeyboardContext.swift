//
//  KeyboardContext.swift
//  Pods-TABTestKit_Example
//
//  Created by Kane Cheshire on 15/10/2019.
//

import XCTest

/// KeyboardContext contains functions for interacting and verifying the keyboard on-screen.
public protocol KeyboardContext {}
public extension KeyboardContext {
	
	func keyboardType(is type: Keyboard.KeyboardType) {
		let actual = keyboard.keyboardType
		XCTAssertEqual(type, actual, "Actual keyboard type (\(actual)) does not match expected keyboard type (\(type))")
	}
	
}
