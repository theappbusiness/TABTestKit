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
	
	/// The app this screen is in. Defaults to the main app, but you can provide other apps (like Safari).
	var app: BaseApp { get }

}

public extension Screen {
	
	var app: BaseApp { return App() }
	
}
