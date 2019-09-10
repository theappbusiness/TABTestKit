//
//  Alert.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents an Alert element.
/// See also: `AlertContext`
public struct Alert: Element {
	
	public let id: String
	public let type: XCUIElement.ElementType = .alert
	public let confirmButton: Button
	public let dismissButton: Button?
	
	public init(id: String, confirmButton: Button, dismissButton: Button? = nil) {
		self.id = id
		self.confirmButton = confirmButton
		self.dismissButton = dismissButton
	}
	
}

public extension Alert {
	
	/// Represents a button in the alert.
	struct Button: Element, Tappable {
		
		public let id: String
		public let type: XCUIElement.ElementType = .button
		
		public init(id: String) {
			self.id = id
		}
		
	}
	
}
