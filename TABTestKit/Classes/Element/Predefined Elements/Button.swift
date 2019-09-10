//
//  Button.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a Button element.
public struct Button: Element, Tappable {

	public let id: String
	public let parent: XCUIElement
	public let type: XCUIElement.ElementType = .button
	
	public init(id: String, parent: Element = nil) {
		self.id = id
		self.parent = parent?.underlyingXCUIElement ?? App()
	}
	
}
