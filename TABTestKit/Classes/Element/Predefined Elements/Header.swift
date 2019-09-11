//
//  Header.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a Header element.
/// You must give a view the `.header` trait in code before
/// it will be recognized as a Header (some UIKit views have this already,
/// like UITableView section headers).
/// This is typically what you should use as a Screen's trait (or a ViewController).
public struct Header: Element, ValueRepresentable {
	
	public let id: String
	public let type: XCUIElement.ElementType = .other
	public let parent: Element
	public var value: String { return underlyingXCUIElement.label }
	
	public init(id: String, parent: Element = App()) {
		self.id = id
		self.parent = parent
	}
	
}
