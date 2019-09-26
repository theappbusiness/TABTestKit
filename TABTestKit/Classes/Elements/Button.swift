//
//  Button.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a Button element.
public struct Button: Element, Tappable, ValueRepresentable {
	
	public let id: String?
	public let index: Int
	public let parent: Element
	public let type: XCUIElement.ElementType = .button
	public var value: String { return underlyingXCUIElement.label }
	
	public init(id: String, index: Int = 0, parent: Element = App.shared) {
		self.id = id
		self.index = index
		self.parent = parent
	}
	
}
