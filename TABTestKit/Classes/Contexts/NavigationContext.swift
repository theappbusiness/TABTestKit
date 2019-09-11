//
//  NavigationContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol NavigationContext {}
public extension NavigationContext {
	
	/// Asserts that a screen can be seen, by awaiting on its trait.
	///
	/// - Parameter screen: The screen to await.
	func see<ScreenType: Screen>(_ screen: ScreenType) {
		see(screen.trait)
	}
	
	/// Asserts that a screen does not exist, by awaiting on its trait.
	///
	/// - Parameter screen: The screen to await.
	func doNotSee<ScreenType: Screen>(_ screen: ScreenType) {
		doNotSee(screen.trait)
	}
	
	/// Asserts that an element can be seen, by awaiting for it to exist and be visible.
	///
	/// - Parameter element: The element to await.
	func see(_ element: Element) {
		element.await(.exists, .visible)
	}
	
	/// Asserts that an element does not exist, by waiting for it to not exist.
	///
	/// - Parameter element: The element to await.
	func doNotSee(_ element: Element) {
		element.await(.doesNotExist)
	}
	
	/// Asserts that an element has a value that matches the expected value.
	///
	/// - Parameters:
	///   - value: The value to assert.
	///   - element: The element that has the value to assert against.
	func see<ElementType: Element & ValueRepresentable>(_ value: ElementType.Value, in element: ElementType) {
		see(element)
		XCTAssertEqual(value, element.value)
	}
	
	/// Completes a
	///
	/// - Parameter screens: <#screens description#>
	func complete<ScreenType: Completable & Screen>(_ screens: ScreenType...) {
		screens.forEach { screen in
			see(screen)
			screen.complete()			
		}
	}
	
	func dismiss<ScreenType: Dismissable & Screen>(_ screen: ScreenType) {
		see(screen)
		screen.dismiss()
	}
	
}
