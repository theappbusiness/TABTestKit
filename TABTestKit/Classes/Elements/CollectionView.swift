//
//  CollectionView.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a UICollectionView element.
public struct CollectionView: Element, Scrollable, CellContaining {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .collectionView
	
	public init(id: String? = nil, parent: Element = App.shared) {
		self.id = id
		self.parent = parent
	}
	
}
