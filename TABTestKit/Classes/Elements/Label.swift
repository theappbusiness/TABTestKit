//
//  Label.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a basic Label element.
public struct Label: Element {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .staticText
	
	public init(id: String, parent: Element = App()) {
		self.id = id
		self.parent = parent
	}
	
}
