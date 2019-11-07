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
	public let type: XCUIElement.ElementType = .other // This is ignored on iOS 13+ because of silliness with XCTest, see below.
	public var value: String { return label }
	
	public init(id: String?, parent: Element = App.shared) {
		self.id = id
		self.parent = parent
	}
	
	public var underlyingXCUIElement: XCUIElement {
		if #available(iOS 13.0, *) {
			return customQueryWorkaroundForiOS13
		}
		return defaultUnderlyingXCUIElement
	}
	
}

private extension Header {
	
	/// In iOS 13 (and maybe above), UILabels are always referenced by XCUI as `.staticText`, even if they have the `.header` trait available.
	/// Frustratingly, this isn't the case for other views with the `.header` trait (like `UITableView` section headers), so we cannot just change
	/// the element's `type` to `.staticText`, because it will fail in some other cases.
	///
	/// The way we've worked around this is to find _all_ elements matching the provided ID,
	/// and then use a private API to get the underlying accessibility traits of the view the XCUIElement represents and filter all
	/// of the matched elements by the ones that have the `.header` trait.
	///
	/// We then retrieve the header by index (if it exists), if not it defaults to the standard query for the underlying `XCUIElement`
	/// so that we can still check if an element doesn't exist without crashing the tests.
	@available(iOS 13.0, *)
	var customQueryWorkaroundForiOS13: XCUIElement {
		let allElementsMatchingID = parent.underlyingXCUIElement.descendants(matching: .any).matching(.any, identifier: id)
		let allHeaders = allElementsMatchingID.allElementsBoundByAccessibilityElement.filter { $0.underlyingAccessibilityTraits.contains(.header) }
		return allHeaders[index] ?? defaultUnderlyingXCUIElement
	}
	
}
