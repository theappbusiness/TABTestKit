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
	public let index: Int
    public let name: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .scrollView
	
	public init(id: String? = nil, index: Int = 0, name: String? = nil, parent: Element = App.shared) {
		self.id = id
		self.index = index
        self.name = name
		self.parent = parent
	}
	
}
