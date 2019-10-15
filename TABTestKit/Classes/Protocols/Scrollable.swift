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

public extension Element where Self: Scrollable {
	
	func scroll(_ direction: ElementAttributes.Direction) {
		await(.exists, .hittable)
		switch direction {
		case .upwards:
			underlyingXCUIElement.swipeDown()
		case .downwards:
			underlyingXCUIElement.swipeUp()
		case .left:
			underlyingXCUIElement.swipeRight()
		case .right:
			underlyingXCUIElement.swipeLeft()
		case .from(let from, let to):
			let fromCoordinate = underlyingXCUIElement.coordinate(withNormalizedOffset: from)
			let toCoordinate = underlyingXCUIElement.coordinate(withNormalizedOffset: to)
			fromCoordinate.press(forDuration: 0, thenDragTo: toCoordinate)
		}
	}
	
}
