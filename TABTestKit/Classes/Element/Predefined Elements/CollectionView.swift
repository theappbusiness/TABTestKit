//
//  CollectionView.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a UICollectionView element.
public struct CollectionView: Element, Scrollable, CellContaining {
	
	public let id: String
	public let type: XCUIElement.ElementType = .collectionView
	public let parent: Element
	
	public init(id: String = "", parent: Element = App()) {
		self.id = id
		self.parent = parent
	}
	
}

public extension CollectionView {
	
	/// Represents a UICollectionViewCell.
	struct Cell: Element, Tappable {
		
		public let id: String
		public let parent: Element
		public let type: XCUIElement.ElementType = .cell
		public let index: Int
		public var value: String { return underlyingXCUIElement.label }
		
		/// Creates a new CollectionView.Cell instance.
		/// - Parameter id: The ID of the cell. You should set this in code as the accessibilityIdentifier, or as the accessibilityLabel.
		/// - Parameter index: The index of the cell in the collection view. Sections are not supported in UI tests, so the index accounts for ALL cells.
		/// - Parameter collectionView: The parent/containing collection view of the cell.
		public init(id: String, index: Int = 0, collectionView: CollectionView = CollectionView()) {
			self.id = id
			self.index = index
			self.parent = collectionView
		}
		
	}
	
}
