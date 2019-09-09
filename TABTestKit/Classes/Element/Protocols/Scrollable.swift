//
//  Scrollable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

/// Represents a type that can be scrolled.
/// Any Element that conforms to Scrollable will get this behaviour for free.
public protocol Scrollable {
	
	/// Scrolls in a direction.
	/// - Parameter direction: The direction to scroll in.
	func scroll(_ direction: ElementAttributes.Direction)
	
}

public extension Scrollable where Self: Element {
	
	func scroll(_ direction: ElementAttributes.Direction) {
		await(.exists, .hittable)
		switch direction {
		case .up:
			underlyingXCUIElement.swipeDown() // TODO: Better scrolling
		case .down:
			underlyingXCUIElement.swipeUp()
		case .left:
			underlyingXCUIElement.swipeRight()
		case .right:
			underlyingXCUIElement.swipeLeft()
		}
	}
	
}
