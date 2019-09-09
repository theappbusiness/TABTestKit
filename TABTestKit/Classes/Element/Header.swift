//
//  Header.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public struct Header: Element, ValueRepresenting {
	
	public let id: String
	public let type: XCUIElement.ElementType = .other
	public var value: String { underlyingXCUIElement.label }
	
	public init(id: String) {
		self.id = id
	}
	
}
