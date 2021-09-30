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
	
	public let id: String?
	public let parent: Element
	public let message: String?
	public let type: XCUIElement.ElementType = .alert
	public var dismissButton: Button {
		return Button(id: dismissButtonID, parent: self)
	}
	
	private let dismissButtonID: String
	
	public init(id: String?, message: String? = nil, parent: Element = App.shared, dismissButtonID: String = "Cancel") {
		self.id = id
		self.message = message
		self.parent = parent
		self.dismissButtonID = dismissButtonID
	}
	
	public func actionButton(withID actionButtonID: String) -> Button {
		return Button(id: actionButtonID, parent: self)
	}
	
}

extension Alert: Dismissable {
	
	public func dismiss() {
		dismissButton.tap()
	}
	
}
