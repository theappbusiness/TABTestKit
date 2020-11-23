//
//  TextView.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a UITextView element,
public struct TextView: Element, Editable, Tappable, Scrollable, ValueRepresentable {
	
	public let id: String?
    public let name: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .textView
	public var value: String { return underlyingXCUIElement.value as? String ?? "" }
	
	public init(id: String, name: String? = nil, parent: Element = App.shared) {
		self.id = id
        self.name = name
		self.parent = parent
	}
	
}
