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
	
	/// Represents the frame of the element, within the screen.
	var frameInScreen: CGRect { get }
	
	/// The top coordinate of the element, relative to the screen.
	var topCoordinate: CGVector { get }
	
	/// The underlying XCUIElement that this element represents. You should rarely need to access or override this, but you can if you need to.
	var underlyingXCUIElement: XCUIElement { get }
	
}

public extension Element {
	
	var parent: Element { return App.shared }
	
	var index: Int { return 0 }
	
	var label: String { return underlyingXCUIElement.label }
	
	var value: String? { return underlyingXCUIElement.value as? String }
	
	var frameInScreen: CGRect { return underlyingXCUIElement.frame }
	
	var topCoordinate: CGVector { return defaultTopCoordinate }
	
	var underlyingXCUIElement: XCUIElement { return defaultUnderlyingXCUIElement }
	
}

public extension Element {
	
	/// Awaits for the provided states to be true with a max timeout.
	/// Unlike the standard `determine` function which returns the state after a max duration, this function will fail the test if any of the states do not become true before the timeout.
	///
	/// You can provide multiple states, like `await(.exists, .hittable)`
	///
	/// - Parameter states: The states to wait for.
	/// - Parameter timeout: The timeout. Defaults to 30 seconds.
  @available(swift, introduced: 5.0, obsoleted: 5.5, renamed: "waitFor", message: "This method has been obsoleted to avoid conflicts with the new await concurrency keyword")
	func await(_ states: ElementAttributes.State..., timeout: TimeInterval = 30) {
    guard !states.isEmpty else { XCTFatalFail("You must provide at least one state!") }
    states.forEach { state in
      XCTAssertTrue(determine(state, timeout: timeout), "Failed awaiting element to be \(state) with timeout \(timeout)")
    }
	}

  /// Converse to the `await(_ states...` function, this waits for the element to _not_ be in the states
  /// provided.
  /// For example, you could use this to wait for an element that you're expecting to become not hittable:
  /// `await(not: .hittable)`
  ///
  /// - Parameters:
  ///   - states: The states to wait for the element to _not_ be in.
  ///   - timeout: The timout. Defaults to 30 seconds.
  @available(swift, introduced: 5.0, obsoleted: 5.5, renamed: "waitFor", message: "This method has been obsoleted to avoid conflicts with the new await concurrency keyword")
  func await(not states: ElementAttributes.State..., timeout: TimeInterval = 30) {
    guard !states.isEmpty else { XCTFatalFail("You must provide at least one state!") }
    states.forEach { state in
      XCTAssertTrue(determine(not: state, timeout: timeout), "Failed awaiting element to be \(state) with timeout \(timeout)")
    }
  }

  /// Waits for the provided states to be true with a max timeout.
  /// Unlike the standard `determine` function which returns the state after a max duration, this function will fail the test if any of the states do not become true before the timeout.
  ///
  /// You can provide multiple states, like `waitFor(.exists, .hittable)`
  ///
  /// - Parameter states: The states to wait for.
  /// - Parameter timeout: The timeout. Defaults to 30 seconds.
  @available(swift, introduced: 5.5)
  func waitFor(_ states: ElementAttributes.State..., timeout: TimeInterval = 30) {
    guard !states.isEmpty else { XCTFatalFail("You must provide at least one state!") }
    states.forEach { state in
      XCTAssertTrue(determine(state, timeout: timeout), "Failed awaiting element to be \(state) with timeout \(timeout)")
    }
  }

  /// Converse to the `waitFor(_ states...` function, this waits for the element to _not_ be in the states
  /// provided.
  /// For example, you could use this to wait for an element that you're expecting to become not hittable:
  /// `waitFor(not: .hittable)`
  ///
  /// - Parameters:
  ///   - states: The states to wait for the element to _not_ be in.
  ///   - timeout: The timout. Defaults to 30 seconds.
  @available(swift, introduced: 5.5)
  func waitFor(not states: ElementAttributes.State..., timeout: TimeInterval = 30) {
    guard !states.isEmpty else { XCTFatalFail("You must provide at least one state!") }
    states.forEach { state in
      XCTAssertTrue(determine(not: state, timeout: timeout), "Failed awaiting element to not be \(state) with timeout \(timeout)")
    }
  }
	
	/// Determines the sates for an element, within a  a maximum duration.
	/// If the element becomes (or already is) in the correct state this function will exit early,
	/// otherwise it will keep trying until the timeout and eventually return `false`.
	///
	/// You can provide multiple states, like `await(.exists, .hittable)`
	///
	/// - Parameters:
	///   - states: The states to determine the element is in.
	///   - timeout: The maxium duration the state should be waited for. Defaults to 10 seconds.
	/// - Returns: `true` if the element ends up in the required state before the timeout.
	func determine(_ states: ElementAttributes.State..., timeout: TimeInterval = 10) -> Bool {
		guard !states.isEmpty else { XCTFatalFail("You must provide at least one state!") }
		for state in states {
			switch state {
			case .exists:
				guard underlyingXCUIElement.wait(for: underlyingXCUIElement.exists, timeout: timeout) else { return false }
			case .hittable:
				guard underlyingXCUIElement.wait(for: underlyingXCUIElement.isHittable, timeout: timeout) else { return false }
			case .visible:
				guard underlyingXCUIElement.wait(for: underlyingXCUIElement.isVisible(in: parent.underlyingXCUIElement), timeout: timeout) else { return false }
			case .visibleIn(let element):
				guard underlyingXCUIElement.wait(for: underlyingXCUIElement.isVisible(in: element.underlyingXCUIElement), timeout: timeout) else { return false }
			case .selected:
				guard underlyingXCUIElement.wait(for: underlyingXCUIElement.isSelected, timeout: timeout) else { return false }
			case .enabled:
				guard underlyingXCUIElement.wait(for: underlyingXCUIElement.isEnabled, timeout: timeout) else { return false }
			case .hasKeyboardFocus:
				guard underlyingXCUIElement.wait(for: underlyingXCUIElement.hasKeyboardFocus, timeout: timeout) else { return false }
			}
		}
		return true
	}
	
	/// Converse to the `determine` function, this determines if the element is _not_ in the provided states.
	/// For example you could use this function to determine if the element is _not_ hittable:
	/// `determine(not: .hittable)`
	///
	/// - Parameters:
	///   - states: The states to determine the element is _not_ in.
	///   - timeout: The maximum duration the state should be waited for. Defaults to 10 seconds.
	/// - Returns: `true` if the element ends up _not_ in the state before the timout.
	func determine(not states: ElementAttributes.State..., timeout: TimeInterval = 10) -> Bool {
		guard !states.isEmpty else { XCTFatalFail("You must provide at least one state!") }
		for state in states {
			switch state {
			case .exists:
				guard underlyingXCUIElement.wait(for: !underlyingXCUIElement.exists, timeout: timeout) else { return false }
			case .hittable:
				guard underlyingXCUIElement.wait(for: !underlyingXCUIElement.isHittable, timeout: timeout) else { return false }
			case .visible:
				guard underlyingXCUIElement.wait(for: !underlyingXCUIElement.isVisible(in: parent.underlyingXCUIElement), timeout: timeout) else { return false }
			case .visibleIn(let element):
				guard underlyingXCUIElement.wait(for: !underlyingXCUIElement.isVisible(in: element.underlyingXCUIElement), timeout: timeout) else { return false }
			case .selected:
				guard underlyingXCUIElement.wait(for: !underlyingXCUIElement.isSelected, timeout: timeout) else { return false }
			case .enabled:
				guard underlyingXCUIElement.wait(for: !underlyingXCUIElement.isEnabled, timeout: timeout) else { return false }
			case .hasKeyboardFocus:
				guard underlyingXCUIElement.wait(for: !underlyingXCUIElement.hasKeyboardFocus, timeout: timeout) else { return false }
			}
		}
		return true
	}
	
}
