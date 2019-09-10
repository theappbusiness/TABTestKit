//
//  XCUIElement+isVisible.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public extension XCUIElement {
	
	/// Determines whether the element is visible.
	/// The result is determined by assessing if the element's frame
	/// intersects with the device's window frame.
	var isVisible: Bool {
		guard !frame.isEmpty else { return false }
		return XCUIDevice.shared.frame.intersects(frame)
	}
	
}
