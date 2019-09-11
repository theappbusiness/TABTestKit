//
//  ScrollView.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a basic UIScrollView element.
public struct ScrollView: Element, Scrollable {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .scrollView
	
	public init(id: String? = nil, parent: Element = App()) {
		self.id = id
		self.parent = parent
	}
	
}
