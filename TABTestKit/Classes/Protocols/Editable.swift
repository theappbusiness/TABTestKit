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
		await(.exists, .hittable)
		underlyingXCUIElement.typeText(text)
	}
	
	func delete(numberOfCharacters: Int) {
		await(.exists, .hittable)
		let deletionCharacters = String(repeating: XCUIKeyboardKey.delete.rawValue, count: numberOfCharacters)
		underlyingXCUIElement.typeText(deletionCharacters)
	}
	
}

public extension Element where Self: Editable & ValueRepresentable {

    func clear() {
        await(.exists, .hittable)
        underlyingXCUIElement.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9)).tap()
        underlyingXCUIElement.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: value?.count ?? 0))
    }
}
