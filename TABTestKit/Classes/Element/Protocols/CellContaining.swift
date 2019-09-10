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
	/// - Parameter id: The id to match.
	func numberOfCells(matchingID id: String) -> Int
	
}

public extension Element where Self: CellContaining {
	
	func numberOfCells(matchingID id: String) -> Int {
		return underlyingXCUIElement.cells.matching(identifier: id).count
	}
	
}
