//
//  XCUIElement+waitToBecomeHittable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 06/09/2019.
//

import XCTest

extension XCUIElement { // TODO: Move
	
	var isVisible: Bool {
		guard exists && !frame.isEmpty && frame.origin.x != 0.0 else { return false }
		return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
	}
	
}

extension XCUIElement {
	
	func wait(for somethingThatShouldBeTrue: @autoclosure () -> Bool, timeout: TimeInterval, file: StaticString = #file, line: UInt = #line) {
		var interval = 0.0
		repeat {
			let shouldTryAgain = !somethingThatShouldBeTrue()
			guard shouldTryAgain else { return }
			interval += 1
			sleep(1)
		} while interval <= timeout
		XCTFail("Failed waiting for element state", file: file, line: line)
	}
	
}
