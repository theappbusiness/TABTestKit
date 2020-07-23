//
//  InteractionContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol InteractionContext {}
public extension InteractionContext {
	
	func tap(_ element: Tappable) {
		element.tap()
	}
	
	func type(_ text: String, into element: Editable) {
		element.type(text)
	}
	
	func delete(_ numberOfCharacters: Int, charactersFrom element: Editable) {
		element.delete(numberOfCharacters: numberOfCharacters)
	}
	
	func state(of element: Element, is states: ElementAttributes.State...) {
		states.forEach { element.await($0) }
	}
	
	func state(of element: Element, isNot states: ElementAttributes.State...) {
		states.forEach { element.await(not: $0) }
	}
	
	func scroll(_ element: Scrollable, _ direction: ElementAttributes.Direction, until otherElement: Element, is states: ElementAttributes.State..., maxTries: Int = 10) {
		states.forEach { state in
			var numberOfTries = 0
			repeat {
				guard !otherElement.determine(state, timeout: 1) else { return }
				numberOfTries += 1
				element.scroll(direction)
			} while numberOfTries <= maxTries
			XCTFail("Ran of out tries (\(maxTries)) waiting for element to become \(state)")
		}
	}
	
	func scroll(_ element: Scrollable, _ direction: ElementAttributes.Direction, until otherElement: Element, isNot states: ElementAttributes.State..., maxTries: Int = 10) {
		states.forEach { state in
			var numberOfTries = 0
			repeat {
				guard !otherElement.determine(not: state, timeout: 1) else { return }
				numberOfTries += 1
				element.scroll(direction)
			} while numberOfTries <= maxTries
			XCTFail("Ran of out tries (\(maxTries)) waiting for element to become not \(state)")
		}
	}
    
    func scroll(_ element: Scrollable, _ direction: ElementAttributes.Direction, until otherElement: Element, valueIs value: String, maxTries: Int = 10) {
            var numberOfTries = 0
            repeat {
                guard !(otherElement.value == value) else { return }
                numberOfTries += 1
                element.scroll(direction)
            } while numberOfTries <= maxTries
            XCTFail("Ran of out tries (\(maxTries)) waiting for element to become \(value)")
    }
	
	func value<ElementWithValue: Element & ValueRepresentable>(of element: ElementWithValue, is expectedValue: ElementWithValue.Value) {
		XCTAssertTrue(element.underlyingXCUIElement.wait(for: element.value == expectedValue), "Element did not have the right value before timing out! Expected: \(expectedValue), actual: \(element.value)")
	}
	
	func label(of element: Element, is expectedLabel: String) {
	  XCTAssertTrue(element.underlyingXCUIElement.wait(for: element.label == expectedLabel), "Element did not have the right label before timing out! Expected: \(expectedLabel), actual: \(element.label)")
	}
	
	func adjust<AdjustableElement: Adjustable>(_ element: AdjustableElement, to newValue: AdjustableElement.Value) {
		element.adjust(to: newValue)
	}
	
}
