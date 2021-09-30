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
public protocol Screen {

	associatedtype Trait: Element
	/// The trait of the screen. Typically a ViewController or Header.
	/// By default, the traits are used to await a screen.
	var trait: Trait { get }

}

public extension Screen {
	
	func await() {
    #if swift(>=5.5)
      trait.waitFor(.exists, .hittable, .visible)
    #else
		  trait.await(.exists, .hittable, .visible)
    #endif
	}
	
}
