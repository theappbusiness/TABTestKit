//
//  Editable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents a type that is Editable,
/// which can have text typed into or deleted from it.
///
/// Any Element that conforms to Editable will get this behaviour for free.
public protocol Editable  {
	
	func type(_ text: String)
	func delete(numberOfCharacters: Int)
	
}

public extension Element where Self: Editable {
	
	func type(_ text: String) {
    #if swift(>=5.5)
      waitFor(.exists, .hittable)
    #else
		  await(.exists, .hittable)
    #endif
		underlyingXCUIElement.typeText(text)
	}
	
	func delete(numberOfCharacters: Int) {
    #if swift(>=5.5)
      waitFor(.exists, .hittable)
    #else
		  await(.exists, .hittable)
    #endif
		let deletionCharacters = String(repeating: XCUIKeyboardKey.delete.rawValue, count: numberOfCharacters)
		underlyingXCUIElement.typeText(deletionCharacters)
	}
	
}
