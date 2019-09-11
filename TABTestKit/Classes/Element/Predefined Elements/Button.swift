//
//  Button.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a Button element.
public struct Button: Element, Tappable, ValueRepresentable {
	
	public let id: String
	public let parent: Element
	public let type: XCUIElement.ElementType = .button
	public var value: String { return underlyingXCUIElement.label } // TODO: Not sure about how this will work with Sliders etc
	
	public init(id: String, parent: Element = App()) {
		self.id = id
		self.parent = parent
	}
	
}
