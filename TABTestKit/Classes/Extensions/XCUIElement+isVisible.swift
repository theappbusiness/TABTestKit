//
//  XCUIElement+isVisible.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

extension XCUIElement {
	
	var isVisible: Bool {
		guard exists && !frame.isEmpty && frame.origin.x != 0.0 else { return false }
		return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
	}
	
}
