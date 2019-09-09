//
//  CollectionView.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public struct CollectionView: Element, Scrollable {
	
	public let id: String
	public let type: XCUIElement.ElementType = .collectionView
	
	public init(id: String) {
		self.id = id
	}
	
}

public struct CollectionViewCell: Element, ValueRepresenting {
	
	public let id: String
	public let parent: XCUIElement
	public let type: XCUIElement.ElementType = .cell
	public var value: String { underlyingXCUIElement.label }
	
	public init(id: String, collectionView: CollectionView) {
		self.id = id
		self.parent = collectionView.underlyingXCUIElement
	}
	
}
