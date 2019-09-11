//
//  Table.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a UITableView element.
public struct Table: Element, Scrollable, CellContaining {
	
	public let id: String
	public let type: XCUIElement.ElementType = .table
	public let parent: Element
	
	public init(id: String = "", parent: Element = App()) {
		self.id = id
		self.parent = parent
	}
	
	public func header(withID id: String) -> Header {
		return Header(id: id, parent: self)
	}
	
}

public extension Table {
	
	/// Represents a UITableViewCell
	struct Cell: Element, Tappable {
		
		public let id: String
		public let parent: Element
		public let type: XCUIElement.ElementType = .cell
		public let index: Int
		public var value: String { return underlyingXCUIElement.label }
		
		/// Creates a new Table.Cell instance.
		/// - Parameter id: The ID of the cell. You should set this in code as the accessibilityIdentifier, or as the accessibilityLabel.
		/// - Parameter index: The index of the cell in the table. Sections are not supported in UI tests, so the index accounts for ALL cells.
		/// - Parameter table: The parent/containing table of the cell.
		public init(id: String, index: Int = 0, table: Table = Table()) {
			self.id = id
			self.index = index
			self.parent = table
		}
		
	}
	
}
