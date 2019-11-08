//
//  XCUIElement+isVisible.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public extension XCUIElement {
	
	/// Determines whether this element is visible in another element.
	///
	/// This is determined by checking if the frames intersect, so might not
	/// necessarily be "in" the other element in terms of hierarchy.
	/// - Parameter otherElement: The element to check if the frames intersect.
	/// - Returns: true if the frames of both elements intersect.
	func isVisible(in otherElement: XCUIElement) -> Bool {
		guard exists && otherElement.exists else { return false }
		return otherElement.frame.intersects(frame)
	}
	
}
