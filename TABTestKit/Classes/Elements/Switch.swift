//
//  Switch.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 12/09/2019.
//

import XCTest

public struct Switch: Element, ValueRepresentable, Adjustable, Tappable {
	
	public enum State: Int {
		case off, on
	}
	
	public let id: String?
	public let index: Int
	public let parent: Element
	public let type: XCUIElement.ElementType = .switch
	public var value: State {
		let rawInt = Int(underlyingXCUIElement.value as! String)!
		return State(rawValue: rawInt)!
	}
	
	public init(id: String, index: Int = 0, parent: Element = App.shared) {
		self.id = id
		self.index = index
		self.parent = parent
	}
	
	public func adjust(to newValue: State) {
		guard newValue != value else { XCTFatalFail("Switch is already in state \(newValue)") }
		tap()
		XCTAssert(underlyingXCUIElement.wait(for: newValue == value, timeout: 1), "Failed waiting for Switch to have state \(newValue)")
	}
	
}
