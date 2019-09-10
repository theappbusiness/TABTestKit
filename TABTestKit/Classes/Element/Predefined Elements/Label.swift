//
//  Label.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a basic Label element.
public struct Label: Element {
	
	public let id: String
	public let type: XCUIElement.ElementType = .staticText
	public var value: String { return underlyingXCUIElement.label }
	
	public init(id: String) {
		self.id = id
	}
	
}
