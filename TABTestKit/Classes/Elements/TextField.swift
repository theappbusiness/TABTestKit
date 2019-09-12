//
//  TextField.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a standard UITextField.
public struct TextField: Element, Editable, Tappable, ValueRepresentable {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .textField
	public var value: String { return underlyingXCUIElement.value as? String ?? "" }
	public var placeholder: String? { return underlyingXCUIElement.placeholderValue }
	
	public init(id: String, parent: Element = App.shared) {
		self.id = id
		self.parent = parent
	}
	
}
