//
//  CellContaining.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a type that contains cells.
/// Elements that conform to CellContaining get this behaviour for free.
public protocol CellContaining {
	
	/// The number of cells matching the provided ID that the container holds.
	/// Note that this doesn't necessarily represent the total amount of cells that the
	/// element holds, and will only return the number of currently dequeued cells
	/// which will change based on screen size.
	///
	/// - Parameter id: The id to match.
	func numberOfCells(matchingID id: String?) -> Int
	
	/// Returns a cell within the container, optionally matched by a specific ID.
	///
	/// - Parameters:
	///   - id: The ID of the cell, or nil if you just want to match all cells by index.
	///   - index: The index of the cell.
	/// - Returns: A cell inside the container.
	func cell(matchingID id: String?, index: Int) -> Cell
	
}

public extension Element where Self: CellContaining {
	
	func numberOfCells(matchingID id: String? = nil) -> Int {
		return underlyingXCUIElement.cells.matching(.cell, identifier: id).count
	}
	
	func cell(matchingID id: String? = nil, index: Int = 0) -> Cell {
		return Cell(id: id, index: index, parent: self)
	}
	
}
