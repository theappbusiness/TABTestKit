//
//  Header.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a Header element.
///
/// You must give a view the `.header` trait in code before
/// it will be recognized as a Header (some UIKit views have this already,
/// like UITableView section headers).
///
/// This is typically what you should use as a Screen's trait (or a ViewController).
public struct Header: Element, ValueRepresentable {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .other
	public var value: String { return label }
	
	public init(id: String?, parent: Element = App.shared) {
		self.id = id
		self.parent = parent
	}
	
	public var underlyingXCUIElement: XCUIElement {
		if #available(iOS 13.0, *) {
			let allElementsMatchingID = parent.underlyingXCUIElement.descendants(matching: .any).matching(.any, identifier: id)
			let allHeaders = allElementsMatchingID.allElementsBoundByAccessibilityElement.filter { $0.underlyingAccessibilityTraits.contains(.header) }
			return allHeaders.indices.contains(index) ? allHeaders[index] : defaultUnderlyingXCUIElement
		} else {
			return defaultUnderlyingXCUIElement
		}
	}
	
}
