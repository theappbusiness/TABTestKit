//
//  ViewController.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a controller in your app.
/// More specifically, you actually set the identifier on a view controller's view:
/// `viewController.view.accessibilityIdentifier = "SomeIdentifier"`
/// This is typically what you should use as a Screen's trait (or a Header).
public struct ViewController: Element {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .other
	
	public init(id: String, parent: Element = App()) {
		self.id = id
		self.parent = parent
	}
	
}
