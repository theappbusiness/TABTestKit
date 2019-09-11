//
//  TextField.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a standard UITextField.
public struct TextField: Element, Editable {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .textField
	
	public init(id: String, parent: Element = App()) {
		self.id = id
		self.parent = parent
	}
	
}
