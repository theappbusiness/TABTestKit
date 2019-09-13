//
//  Table.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a UITableView element.
public struct Table: Element, Scrollable, CellContaining {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .table
	
	public init(id: String? = nil, parent: Element = App.shared) {
		self.id = id
		self.parent = parent
	}
	
	public func header(withID id: String) -> Header {
		return Header(id: id, parent: self)
	}
	
}
