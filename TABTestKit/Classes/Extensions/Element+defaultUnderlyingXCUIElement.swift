//
//  Element+defaultUnderlyingXCUIElement.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 07/11/2019.
//

import XCTest

extension Element {

	/// The default underlying `XCUIElement` using regular `XCUIElementQuery`s.
	var defaultUnderlyingXCUIElement: XCUIElement {
		return parent.underlyingXCUIElement.descendants(matching: type).matching(type, identifier: id).element(boundBy: index)
	}

}
