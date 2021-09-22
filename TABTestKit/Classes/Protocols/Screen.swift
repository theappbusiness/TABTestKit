//
//  Screen.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 06/09/2019.
//

import XCTest

/// Represents a screen in your app, which is pretty analogous to view controllers.
///
/// All screens must have a trait, which can be an instance
/// of any type conforming to Element.
///
/// Typically, you'd just set a Header or ViewController as the trait,
/// but it can be anything.
public protocol Screen: CustomStringConvertible {

	associatedtype Trait: Element
	/// The trait of the screen. Typically a ViewController or Header.
	/// By default, the traits are used to await a screen.
	var trait: Trait { get }

    /// The name of the screen. Used in the step description
    var description: String { get }
}

extension Screen {

    public var description: String {
        return String(describing: Swift.type(of: self)).humanReadableString
    }
}

public extension Screen {
	
	func wait() {
		trait.wait(.exists, .hittable, .visible)
	}
}
