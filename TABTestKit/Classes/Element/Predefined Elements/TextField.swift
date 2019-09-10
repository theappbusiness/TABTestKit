//
//  TextField.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a standard UITextField.
public struct TextField: Element, Editable {
	
	public let id: String
	public let type: XCUIElement.ElementType = .textField
	public var value: String { return underlyingXCUIElement.value as? String ?? "" }
	
	public init(id: String) {
		self.id = id
	}
	
}
