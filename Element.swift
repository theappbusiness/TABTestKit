//
//  Element.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 06/09/2019.
//

import XCTest

public protocol Element_ {
	
	var id: String { get }
	
}

public struct Button_: Element_ {
	
	public let id: String = ""
	public func tap() {
		
	}
	
}

public protocol Screen_ {
	
	associatedtype Trait: Element_
	var trait: Trait { get }
	
}

public struct SomeScreen_: Screen_ {
	
	public let trait = Button_()
	
}

let someScreen = SomeScreen_()
someScreen.trait.tap()

public struct Element {
	
	private let underlyingElement: XCUIElement
	
	init(id: String, index: Int, type: XCUIElement.ElementType, parent: XCUIElement = App.shared) {
		underlyingElement = parent.descendants(matching: type).matching(identifier: id).element(boundBy: index)
	}
	
	init(id: String, type: XCUIElement.ElementType, parent: XCUIElement = App.shared) {
		underlyingElement = parent.descendants(matching: type).matching(identifier: id).firstMatch
	}
	
	init(type: XCUIElement.ElementType, parent: XCUIElement = App.shared) {
		underlyingElement = parent.descendants(matching: type).firstMatch
	}
	
}

public extension Element {
	
	static func navBar() -> Element {
		return Element(type: .navigationBar)
	}
	
	static func header(id: String, index: Int = 0) -> Element {
		Element(id: id, index: index, type: .other)
	}
	
	static func viewController(id: String) -> Element {
		Element(id: id, type: .other)
	}
	
	static func label(id: String, index: Int = 0) -> Element {
		Element(id: id, index: index, type: .staticText)
	}
	
	static func textField(id: String, index: Int = 0) -> Element {
		Element(id: id, index: index, type: .textField)
	}
	
	static func secureTextField(id: String, index: Int = 0) -> Element {
		Element(id: id, index: index, type: .secureTextField)
	}
	
	static func segmentedControl(id: String, index: Int = 0) -> Element {
		Element(id: id, index: index, type: .segmentedControl)
	}
	
	static func table(id: String) -> Element {
		Element(id: id, type: .table)
	}
	
	static func cell(id: String, index: Int, tableID: String) -> Element {
		Element(id: id, index: index, type: .cell, parent: table(id: tableID).underlyingElement)
	}
	
	static func scrollView(id: String) -> Element {
		Element(id: id, type: .scrollView)
	}
	
	static func collectionView(id: String) -> Element {
		Element(id: id, type: .collectionView)
	}
	
}

public extension Element { // TODO: Move
	
	enum State {
		
		case exists
		case doesNotExist
		
		case hittable
		case notHittable
		
		case visible
		case notVisible
		
	}
	
	enum Direction {
		
		case up
		case down
		case left
		case right
		
	}
	
}

public extension Element {
	
	func tap() {
		await(.exists, .hittable, timeout: 30)
		underlyingElement.tap()
	}
	
	func type(_ text: String) {
		underlyingElement.typeText(text)
	}
	
	func await(_ states: State..., timeout: TimeInterval = 30) {
		states.forEach { state in
			switch state {
			case .exists:
				XCTAssertTrue(underlyingElement.wait(for: underlyingElement.exists, timeout: timeout))
			case .doesNotExist:
				XCTAssertTrue(underlyingElement.wait(for: !underlyingElement.exists, timeout: timeout))
			case .hittable:
				XCTAssertTrue(underlyingElement.wait(for: underlyingElement.isHittable, timeout: timeout))
			case .notHittable:
				XCTAssertTrue(underlyingElement.wait(for: !underlyingElement.isHittable, timeout: timeout))
			case .visible:
				XCTAssertTrue(underlyingElement.wait(for: underlyingElement.isVisible, timeout: timeout))
			case .notVisible:
				XCTAssertTrue(underlyingElement.wait(for: underlyingElement.isVisible, timeout: timeout))
			}
		}
	}
	
	func scroll(_ direction: Direction, until element: Element, is state: State) {
		await(.exists, .hittable)
		var numberOfTries = 0
		repeat {
			guard !element.await(state, timeout: 1) else { return }
			if elementIsAsVisibleAsExpected {
				return
			} else {
				numberOfTries += 1
				
			}
		} while numberOfTries <= maxTries
	}
	
}

extension XCUIElement {
	
	func scrollUp() {
		
	}
	
	func scrollDown() {
		
	}
	
	func scrollLeft() {
		
	}
	
	func scrollRight() {
		
	}
	
}
