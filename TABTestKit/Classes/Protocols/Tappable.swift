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
    #if swift(>=5.5)
		  waitFor(.exists)
    #else
      await(.exists)
    #endif
		underlyingXCUIElement.tap()
	}

	func doubleTap() {
    #if swift(>=5.5)
      waitFor(.exists)
    #else
      await(.exists)
    #endif
		underlyingXCUIElement.doubleTap()
	}

	func twoFingerTap() {
    #if swift(>=5.5)
      waitFor(.exists)
    #else
      await(.exists)
    #endif
		underlyingXCUIElement.twoFingerTap()
	}

	func longPress(duration: TimeInterval) {
    #if swift(>=5.5)
      waitFor(.exists)
    #else
      await(.exists)
    #endif
		underlyingXCUIElement.press(forDuration: duration)
	}
	
}
