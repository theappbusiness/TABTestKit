//
//  TextView.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a UITextView element,
public struct TextView: Element, Editable, Scrollable {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .textView
	
	public init(id: String, parent: Element = App.shared) {
		self.id = id
		self.parent = parent
	}
	
}
