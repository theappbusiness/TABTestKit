//
//  InteractionContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol InteractionContext {} // TODO: AppContext
public extension InteractionContext {
	
	func tap(_ element: Tappable) {
		element.tap()
	}
	
	func type(_ text: String, into element: Editable & Tappable, tappingFirst shouldTapFirst: Bool = true) {
		if shouldTapFirst { tap(element) }
		element.type(text)
	}
	
	func scroll(_ element: Scrollable, _ direction: ElementAttributes.Direction, until otherElement: Element, is states: ElementAttributes.State..., maxTries: Int = 10) {
		var numberOfTries = 0
		repeat {
			let isInCorrectState = false // TODO
			guard !isInCorrectState else { return }
			numberOfTries += 1
			element.scroll(direction)
		} while numberOfTries <= maxTries
		XCTFail("Ran of out tries") // TODO: Better failure message
	}
	
}
