//
//  XCUIElement+hasKeyboardFocus.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/10/2019.
//

import XCTest

public extension XCUIElement {
	
	/// Determines whether the element has keyboard focus.
	/// This uses KVC (Key-Value Coding) to ask the element
	/// for its value for the key `hasKeyboardFocus`.
	///
	/// This is a stand-in for the missing `hasFocus` property
	/// that Apple state exists in the online docs, but have
	/// omitted from the XCTest framework.
	var hasKeyboardFocus: Bool {
		return value(forKey: "hasKeyboardFocus") as? Bool ?? false
	}
	
}
