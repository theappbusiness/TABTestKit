//
//  Scrollable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

public protocol Scrollable {
	
	func scroll(direction: ElementAttributes.Direction)
	
}

public extension Scrollable where Self: Element {
	
	func scroll(direction: ElementAttributes.Direction) {
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
