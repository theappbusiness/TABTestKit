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
	public let parent: Element
	public var confirmButton: Button {
		return Button(id: confirmButtonID, parent: self)
	}
	public var dismissButton: Button? {
		guard let id = dismissButtonID else { return nil }
		return Button(id: id, parent: self)
	}
	
	private let confirmButtonID: String // TODO: What happens if there are multiple buttons?
	private let dismissButtonID: String?
	
	public init(id: String, parent: Element = App(), confirmButtonID: String, dismissButtonID: String? = nil) {
		self.id = id
		self.parent = parent
		self.confirmButtonID = confirmButtonID
		self.dismissButtonID = dismissButtonID
	}
	
}
