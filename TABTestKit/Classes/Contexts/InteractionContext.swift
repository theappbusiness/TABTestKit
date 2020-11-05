//
//  InteractionContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol InteractionContext {}
public extension InteractionContext {
	
	func tap(_ element: Tappable) -> StepAction {
        StepAction {
            element.tap()
        }
	}

	func doubleTap(_ element: Tappable) -> StepAction {
        StepAction {
            element.doubleTap()
        }
	}

	func twoFingerTap(_ element: Tappable) -> StepAction {
        StepAction {
            element.twoFingerTap()
        }
	}

	func longPress(_ element: Tappable, duration: TimeInterval = 0.5) -> StepAction {
        StepAction {
            element.longPress(duration: duration)
        }
	}
	
	func type(_ text: String, into element: Editable) -> StepAction {
        StepAction {
            element.type(text)
        }
	}
	
	func delete(_ numberOfCharacters: Int, charactersFrom element: Editable) -> StepAction {
        StepAction {
            element.delete(numberOfCharacters: numberOfCharacters)
        }
	}
	
	func state(of element: Element, is states: ElementAttributes.State...) -> StepAction {
        StepAction {
            states.forEach { element.await($0) }
        }
	}
	
	func state(of element: Element, isNot states: ElementAttributes.State...) -> StepAction {
        StepAction {
            states.forEach { element.await(not: $0) }
        }
	}
	
	func scroll(_ element: Scrollable, _ direction: ElementAttributes.Direction, until otherElement: Element, is states: ElementAttributes.State..., maxTries: Int = 10) -> StepAction {
        StepAction {
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
	
	func scroll(_ element: Scrollable, _ direction: ElementAttributes.Direction, until otherElement: Element, isNot states: ElementAttributes.State..., maxTries: Int = 10) -> StepAction {
        StepAction {
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
	
	func scroll(_ element: Scrollable, _ direction: ElementAttributes.Direction, until otherElement: Element, valueIs value: String, maxTries: Int = 10) -> StepAction {
        StepAction {
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
        StepAction {
            XCTAssertTrue(element.underlyingXCUIElement.wait(for: element.value == expectedValue), "Element did not have the right value before timing out! Expected: \(expectedValue), actual: \(element.value)")
        }
	}
	
	func label(of element: Element, is expectedLabel: String) -> StepAction {
        StepAction {
            XCTAssertTrue(element.underlyingXCUIElement.wait(for: element.label == expectedLabel), "Element did not have the right label before timing out! Expected: \(expectedLabel), actual: \(element.label)")
        }
	}
	
	func adjust<AdjustableElement: Adjustable>(_ element: AdjustableElement, to newValue: AdjustableElement.Value) -> StepAction {
        StepAction {
            element.adjust(to: newValue)
        }
	}
	
	func refresh(_ refreshableThing: Refreshable) -> StepAction {
        StepAction {
            refreshableThing.refresh()
        }
	}
	
}
