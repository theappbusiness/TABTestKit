//
//  Label.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a basic Label element.
public struct Label: Element, ValueRepresentable {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .staticText
	public var value: String { return label } // TODO: Remove `return`s for Swift 5.1+
	
	public init(id: String, parent: Element = App.shared) {
		self.id = id
		self.parent = parent
	}
	
}
