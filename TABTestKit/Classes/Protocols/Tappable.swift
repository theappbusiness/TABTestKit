//
//  Tappable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a Tappable type.
/// Elements that conform to Tappable will get this behaviour for free.
public protocol Tappable {

	func tap()
	func doubleTap()
	func longPress(duration: TimeInterval)
	func twoFingerTap()
	
}

public extension Element where Self: Tappable {

	func tap() {
		wait(.exists)
		underlyingXCUIElement.tap()
	}

	func doubleTap() {
		wait(.exists)
		underlyingXCUIElement.doubleTap()
	}

	func twoFingerTap() {
		wait(.exists)
		underlyingXCUIElement.twoFingerTap()
	}

	func longPress(duration: TimeInterval) {
		wait(.exists)
		underlyingXCUIElement.press(forDuration: duration)
	}
	
}
