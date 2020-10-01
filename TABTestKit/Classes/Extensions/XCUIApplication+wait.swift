//
//  XCUIApplication+wait.swift
//  TABTestKit
//
//  Created by John Sanderson on 01/10/2020.
//

import XCTest

public extension XCUIApplication {

	/// Waits for the application to enter one of the provided states.
	///
	/// - Parameters:
	///   - states: The states to wait for the application to enter.
	///   - timeout: The maximum duration to wait, in sections. Defaults to 10 seconds.
	/// - Returns: `true` if the application enters one of the provided states before the timeout, otherwise `false`.
	func wait(forEither states: [XCUIApplication.State], timeout: TimeInterval) -> Bool {
		var interval = 0.0
		repeat {
			let shouldTryAgain = !states.contains(state)
			guard shouldTryAgain else { return true }
			interval += 1
			sleep(1)
		} while interval <= timeout
		return false
	}
}

