//
//  Editable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol Editable  {
	
	func type(_ text: String)
	func delete(numberOfCharacters: Int)
	
}

public extension Editable where Self: Element {
	
	func type(_ text: String) {
		underlyingXCUIElement.typeText(text)
	}
	
	func delete(numberOfCharacters: Int) {
		let deletionCharacters = String(repeating: XCUIKeyboardKey.delete.rawValue, count: numberOfCharacters)
		underlyingXCUIElement.typeText(deletionCharacters)
	}
	
}
