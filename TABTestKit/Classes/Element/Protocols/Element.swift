//
//  Element.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 06/09/2019.
//

import XCTest

public protocol Element {
	
	var id: String { get }
	var parent: XCUIElement { get }
	var index: Int { get }
	var type: XCUIElement.ElementType { get }
	
}

public extension Element {
	
	var parent: XCUIElement { App() }
	var index: Int { 0 }
	
}

public extension Element {
	
	func await(_ states: ElementAttributes.State..., timeout: TimeInterval = 30) {
		states.forEach { state in
			switch state {
			case .exists:
				underlyingXCUIElement.wait(for: underlyingXCUIElement.exists, timeout: timeout)
			case .doesNotExist:
				underlyingXCUIElement.wait(for: !underlyingXCUIElement.exists, timeout: timeout)
			case .hittable:
				underlyingXCUIElement.wait(for: underlyingXCUIElement.isHittable, timeout: timeout)
			case .notHittable:
				underlyingXCUIElement.wait(for: !underlyingXCUIElement.isHittable, timeout: timeout)
			case .visible:
				underlyingXCUIElement.wait(for: underlyingXCUIElement.isVisible, timeout: timeout)
			case .notVisible:
				underlyingXCUIElement.wait(for: underlyingXCUIElement.isVisible, timeout: timeout)
			}
		}
	}
	
}

extension Element {
	
	var underlyingXCUIElement: XCUIElement {
		parent.descendants(matching: type).matching(identifier: id).element(boundBy: index)
	}
	
}
