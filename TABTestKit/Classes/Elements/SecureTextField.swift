//
//  SecureTextField.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a secure text field (e.g. a password field)
public struct SecureTextField: Element, Editable {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .secureTextField
	
	public init(id: String, parent: Element = App()) {
		self.id = id
		self.parent = parent
	}
	
}
