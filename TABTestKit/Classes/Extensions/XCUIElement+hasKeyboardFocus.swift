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
	
	/// Determines the underlying UIAccessibilityTraits of the view that
	/// this element represents.
	///
	/// NOTE: This uses a private API so is fragile, but is required to
	/// find UILabels with header traits in iOS 13, since Apple have made
	/// it impossible any other way.
	var underlyingAccessibilityTraits: UIAccessibilityTraits {
		guard let rawValue = value(forKey: "traits") as? UInt64 else { return [] }
		return UIAccessibilityTraits(rawValue: rawValue)
	}
	
}
