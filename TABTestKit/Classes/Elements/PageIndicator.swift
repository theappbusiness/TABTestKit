//
//  PageIndicator.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 12/09/2019.
//

import XCTest

public struct PageIndicator: Element, ValueRepresentable {
	
	public let id: String?
	public let index: Int
	public let parent: Element
	public let type: XCUIElement.ElementType = .pageIndicator
	public var value: String { return underlyingXCUIElement.value as? String ?? "" }
	
	public init(id: String? = nil, index: Int = 0, parent: Element = App.shared) {
		self.id = id
		self.index = index
		self.parent = parent
	}
	
}
