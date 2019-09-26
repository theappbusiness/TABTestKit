//
//  Stepper.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 12/09/2019.
//

import XCTest

public struct Stepper: Element {
	
	public let id: String?
	public let index: Int
	public let parent: Element
	public let type: XCUIElement.ElementType = .stepper
	public var incrementButton: Button {
		return Button(id: "Increment", parent: self)
	}
	public var decrementButton: Button {
		return Button(id: "Decrement", parent: self)
	}
	
	public init(id: String, index: Int = 0, parent: Element = App.shared) {
		self.id = id
		self.index = index
		self.parent = parent
	}
	
}
