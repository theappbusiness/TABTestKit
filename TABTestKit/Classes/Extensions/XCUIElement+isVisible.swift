//
//  XCUIElement+isVisible.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public extension XCUIElement {
	
	func isVisible(in otherElement: XCUIElement) -> Bool {
		guard exists else { return false }
		return otherElement.frame.intersects(frame)
	}
	
}
