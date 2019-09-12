//
//  XCUIElement+wait.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 06/09/2019.
//

import XCTest

public extension XCUIElement {
	
	func wait(for somethingThatShouldBeTrue: @autoclosure () -> Bool, timeout: TimeInterval = 10) -> Bool {
		var interval = 0.0
		repeat {
			let shouldTryAgain = !somethingThatShouldBeTrue()
			guard shouldTryAgain else { return true }
			interval += 1
			sleep(1)
		} while interval <= timeout
		return false
	}
	
}
