//
//  Scrollable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation
import CoreGraphics.CGGeometry

/// Represents a type that can be scrolled.
/// Any Element that conforms to Scrollable will get this behaviour for free.
public protocol Scrollable {
	
	/// Scrolls in a direction.
	/// - Parameter direction: The direction to scroll in.
	func scroll(_ direction: ElementAttributes.Direction)
	
}

public extension Element where Self: Scrollable {
	
	func scroll(_ direction: ElementAttributes.Direction) {
    #if swift(>=5.5)
      waitFor(.exists, .hittable)
    #else
      await(.exists, .hittable)
    #endif
		switch direction {
		case .upwards:
			scroll(from: .topThird, to: .middle)
		case .downwards:
			let from: CGVector = keyboard.underlyingXCUIElement.exists ? keyboard.topCoordinate.offset(dx: 0, dy: -0.01) : .middle
			scroll(from: from, to: .topThird)
		case .left:
			scroll(from: .leftThird, to: .middle)
		case .right:
			scroll(from: .rightThird, to: .middle)
		case .from(let from, let to):
			scroll(from: from, to: to)
		}
	}
	
	private func scroll(from: CGVector, to: CGVector) {
		let fromCoordinate = underlyingXCUIElement.coordinate(withNormalizedOffset: from)
		let toCoordinate = underlyingXCUIElement.coordinate(withNormalizedOffset: to)
		fromCoordinate.press(forDuration: 0, thenDragTo: toCoordinate)
	}
	
}
