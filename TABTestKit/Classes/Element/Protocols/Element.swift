//
//  Element.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 06/09/2019.
//

import XCTest

/// Represents a UI element.
/// Pretty much every element on-screen has (or should have) some sort of ID, except for nav bars and tab bars etc.
/// Sometimes identifiers can just be the text of the element, for example a UILabel ID can just be the text.
public protocol Element {
	
	/// The ID of the element. This could be the accessibilityIdentifier or the text of a label.
	var id: String { get }
	/// The parent element. By default the parent element is the app being tested.
	var parent: XCUIElement { get }
	/// The index of the element. 0 by default.
	var index: Int { get }
	/// The type of the element, i.e. button, textField, scrollView.
	var type: XCUIElement.ElementType { get }
	
}

public extension Element {
	
	var parent: XCUIElement { App() }
	var index: Int { 0 }
	
}

public extension Element {
	
	/// Awaits for the provided states to be true with a max timeout.
	/// You can provide multiple states, like `await(.exists, .hittable)`
	/// - Parameter states: The states to wait for.
	/// - Parameter timeout: The timout. Defaults to 30 seconds.
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
				underlyingXCUIElement.wait(for: !underlyingXCUIElement.isVisible, timeout: timeout)
			}
		}
	}
	
}

extension Element {
	
	/// Represents the underlying XCUI element from the XCTest framework.
	/// This is internal, intentionally not exposed to users of TABTestKit so that they have to use
	/// our custom stuff.
	var underlyingXCUIElement: XCUIElement {
		parent.descendants(matching: type).matching(identifier: id).element(boundBy: index)
	}
	
}
