//
//  XCUIElement+wait.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 06/09/2019.
//

import XCTest

public extension XCUIElement {
	
	/// Waits for some expression or value to be true.
	/// Because the parameter takes an autoclosure, it means you can
	/// pass in any single line expression that evaluates to a Bool.
	///
	/// This means you could pass in a function that returns a Bool: `func isTrue() -> Bool`
	/// or an equality check: `isTrue == somethingElseThatIsTrue`
	/// or even just a property: `something.isTrue`
	///
	/// - Parameters:
	///   - somethingThatShouldBeTrue: The single line expression that evaluates to a Bool, that you're expecting to be true.
	///   - timeout: The maximum duration to wait, in sections. Defaults to 10 seconds.
	/// - Returns: `true` if the value becomes true before the timeout, otherwise `false`.
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
