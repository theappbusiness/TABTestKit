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
	/// An ID is not required, but it is recommended.
	/// You may however wish to just match the first navBar (for example), and since there's usually only one navBar in an
	/// app, you don't really need to provide an ID for it.
	var id: String? { get }
	/// The parent element. By default the parent element is the app being tested.
	var parent: Element { get }
	/// The index of the element. 0 by default.
	var index: Int { get }
	/// The type of the element, i.e. button, textField, scrollView.
	var type: XCUIElement.ElementType { get }
	/// The label value of the element. This corresponds to the accessibilityLabel.
	var label: String { get }
	/// The underlying XCUIElement that this element represents. You should rarely need to access this.
	var underlyingXCUIElement: XCUIElement { get }
	
}

public extension Element {
	
	var parent: Element { return App.shared }
	
	var index: Int { return 0 }
	
	var label: String {
		return underlyingXCUIElement.label
	}
	
	var underlyingXCUIElement: XCUIElement {
		return parent.underlyingXCUIElement.descendants(matching: type).matching(type, identifier: id).element(boundBy: index)
	}
	
}

public extension Element {
	
	/// Awaits for the provided states to be true with a max timeout.
	/// Unlike the standard `determine` function which returns the state after a max duration, this function will fail the test if any of the states do not become true before the timeout.
	///
	/// You can provide multiple states, like `await(.exists, .hittable)`
	///
	/// - Parameter states: The states to wait for.
	/// - Parameter timeout: The timout. Defaults to 30 seconds.
	func await(_ states: ElementAttributes.State..., timeout: TimeInterval = 30) {
		states.forEach { state in
			XCTAssertTrue(determine(state, timeout: timeout))
		}
	}
	
	/// Determines the sates for an element, within a  a maximum duration.
	/// If the element becomes (or already is) in the correct state this function will exit early,
	/// otherwise it will keep trying until the timeout and eventually return `false`.
	///
	/// You can provide multiple states, like `await(.exists, .hittable)`
	///
	/// - Parameters:
	///   - states: The states to wait for.
	///   - timeout: The maxium duration the state should be waited for.
	/// - Returns: `true` if the element ends up in the required state before the timeout. Defaults to 30 seconds.
	func determine(_ states: ElementAttributes.State..., timeout: TimeInterval = 30) -> Bool {
		for state in states {
			switch state {
			case .exists:
				guard underlyingXCUIElement.wait(for: underlyingXCUIElement.exists, timeout: timeout) else { return false }
			case .doesNotExist:
				guard underlyingXCUIElement.wait(for: !underlyingXCUIElement.exists, timeout: timeout) else { return false }
			case .hittable:
				guard underlyingXCUIElement.wait(for: underlyingXCUIElement.isHittable, timeout: timeout) else { return false }
			case .notHittable:
				guard underlyingXCUIElement.wait(for: !underlyingXCUIElement.isHittable, timeout: timeout) else { return false }
			case .visible:
				guard underlyingXCUIElement.wait(for: underlyingXCUIElement.isVisible, timeout: timeout) else { return false }
			case .notVisible:
				guard underlyingXCUIElement.wait(for: !underlyingXCUIElement.isVisible, timeout: timeout) else { return false }
			}
		}
		return true
	}
	
}
