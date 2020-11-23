//
//  Cell.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/09/2019.
//

import XCTest

public struct Cell: Element, Tappable {
	
	public let id: String?
    public let index: Int
    public let name: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .cell
	
	public init(id: String? = nil, index: Int = 0, name: String? = nil, parent: Element) {
		self.id = id
		self.index = index
        self.name = name
		self.parent = parent
	}
	
}
