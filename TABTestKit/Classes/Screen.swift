//
//  Screen.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 06/09/2019.
//

import XCTest

protocol Screen {
	
	var trait: Element { get }
	
}

extension Screen {
	
	func await() {
		trait.await()
	}
	
}


protocol Completable { // TODO: Move to own file
	
	func complete()
	
}

protocol Dismissable {
	
	func dismiss()
	
}

protocol NavigationContext {}
extension NavigationContext {
	
	typealias CompletableScreen = Completable & Screen
	typealias DismissableScreen = Dismissable & Screen
	
	func see(_ screen: Screen) {
		screen.await()
	}
	
	func complete(_ screen: CompletableScreen) {
		screen.await()
		screen.complete()
	}
	
	func dismiss(_ screen: DismissableScreen) {
		screen.await()
		screen.dismiss()
	}
	
}

protocol InteractionContext {}
extension InteractionContext {
	
	func tap(_ element: Element, app: XCUIApplication = App.shared) {
		element.tap()
	}
	
	func type(_ text: String, into element: Element, tappingFirst shouldTapFirst: Bool = true) {
		if shouldTapFirst { tap(element) }
		element.type(text)
	}
	
	func tapCoordinate(x xCoordinate: Double, y yCoordinate: Double) {
		let topLeftOfScreen = App.shared.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
		let coordinate = topLeftOfScreen.withOffset(CGVector(dx: xCoordinate, dy: yCoordinate))
		coordinate.tap()
	}
	
}

