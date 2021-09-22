//
//  InteractionContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol InteractionContext {}
public extension InteractionContext {
	
	func tap(_ element: Tappable & CustomStringConvertible) -> StepAction {
        return StepAction(description: "tap on the \(element.description)") {
            element.tap()
        }
	}

	func doubleTap(_ element: Tappable & CustomStringConvertible) -> StepAction {
        return StepAction(description: "double tap on the \(element.description)") {
            element.doubleTap()
        }
	}

	func twoFingerTap(_ element: Tappable & CustomStringConvertible) -> StepAction {
        return StepAction(description: "two finger tap on the \(element.description)") {
            element.twoFingerTap()
        }
	}

	func longPress(_ element: Tappable & CustomStringConvertible, duration: TimeInterval = 0.5) -> StepAction {
        return StepAction(description: "long press on the \(element.description)") {
            element.longPress(duration: duration)
        }
	}
	
	func type(_ text: String, into element: Editable & CustomStringConvertible) -> StepAction {
        return StepAction(description: "type '\(text)' into the \(element.description)") {
            element.type(text)
        }
	}

    func clear<E: Element & Editable & ValueRepresentable & CustomStringConvertible>(_ element: E) -> StepAction {
        return StepAction(description: "clear the \(element.description)") {
            element.clear()
        }
    }
	
	func delete(_ numberOfCharacters: Int, charactersFrom element: Editable & CustomStringConvertible) -> StepAction {
        return StepAction(description: "delete \(numberOfCharacters)  characters from the \(element.description)") {
            element.delete(numberOfCharacters: numberOfCharacters)
        }
	}
	
	func state(of element: Element, is states: ElementAttributes.State...) -> StepAction {

        let stateDescription = states
            .map { $0.description }
            .joined(separator: " and ")

        return StepAction(description: "state of the \(element) \(stateDescription)") {
            states.forEach { element.wait($0) }
        }
	}
	
	func state(of element: Element, isNot states: ElementAttributes.State...) -> StepAction {

        let stateDescription = states
            .map { $0.negativeDescription }
            .joined(separator: " or ")

        return StepAction(description: "state of the \(element) \(stateDescription)") {
            states.forEach { element.wait(not: $0) }
        }
	}
	
	func scroll(_ element: Scrollable & CustomStringConvertible, _ direction: ElementAttributes.Direction, until otherElement: Element, is states: ElementAttributes.State..., maxTries: Int = 10) -> StepAction {

        let stateDescription = states
            .map { $0.description }
            .joined(separator: " and ")

        return StepAction(description: "scroll the \(element) \(direction) until the \(otherElement) \(stateDescription)") {
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
	}
	
	func scroll(_ element: Scrollable & CustomStringConvertible, _ direction: ElementAttributes.Direction, until otherElement: Element, isNot states: ElementAttributes.State..., maxTries: Int = 10) -> StepAction {

        let stateDescription = states
            .map { $0.negativeDescription }
            .joined(separator: " or ")

        return StepAction(description: "scroll the \(element) \(direction) until the \(otherElement) \(stateDescription)") {
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
	}
	
	func scroll(_ element: Scrollable & CustomStringConvertible, _ direction: ElementAttributes.Direction, until otherElement: Element, valueIs value: String, maxTries: Int = 10) -> StepAction {
        return StepAction(description: "scroll the \(element) \(direction) until the \(otherElement)'s value is '\(value)'") {
            var numberOfTries = 0
            repeat {
                guard !(otherElement.value == value) else { return }
                numberOfTries += 1
                element.scroll(direction)
            } while numberOfTries <= maxTries
            XCTFail("Ran of out tries (\(maxTries)) waiting for element to become \(value)")
        }
	}
	
	func value<ElementWithValue: Element & ValueRepresentable>(of element: ElementWithValue, is expectedValue: ElementWithValue.Value) -> StepAction {
        return StepAction(description: "value of the \(element) is '\(expectedValue)'") {
            XCTAssertTrue(element.underlyingXCUIElement.wait(for: element.value == expectedValue), "Element did not have the right value before timing out! Expected: \(expectedValue), actual: \(element.value)")
        }
	}
	
	func label(of element: Element, is expectedLabel: String) -> StepAction {
        return StepAction(description: "label of the \(element) is '\(expectedLabel)'") {
            XCTAssertTrue(element.underlyingXCUIElement.wait(for: element.label == expectedLabel), "Element did not have the right label before timing out! Expected: \(expectedLabel), actual: \(element.label)")
        }
	}
	
	func adjust<AdjustableElement: Adjustable & CustomStringConvertible>(_ element: AdjustableElement, to newValue: AdjustableElement.Value) -> StepAction {
        return StepAction(description: "adjust the \(element) to '\(newValue)'") {
            element.adjust(to: newValue)
        }
	}
	
	func refresh(_ refreshableThing: Refreshable & CustomStringConvertible) -> StepAction {
        return StepAction(description: "refresh the \(refreshableThing)") {
            refreshableThing.refresh()
        }
	}
	
}
