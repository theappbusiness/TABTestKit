//
//  View.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a generic view in your app.
/// This is typically what you should use as a Screen's trait by setting an identifier on viewController.view (or a Header).
public struct View: Element {
	
	public let id: String?
	public let index: Int
	public let parent: Element
	public let type: XCUIElement.ElementType = .other
	
	public init(id: String, index: Int = 0, parent: Element = App.shared) {
		self.id = id
		self.index = index
		self.parent = parent
	}
	
}
