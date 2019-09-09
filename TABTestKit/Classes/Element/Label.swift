//
//  Label.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public struct Label: Element, ValueRepresenting {
	
	public let id: String
	public let type: XCUIElement.ElementType = .staticText
	public var value: String { underlyingXCUIElement.label }
	
	public init(id: String) { // TODO: Needed?
		self.id = id
	}
	
}
