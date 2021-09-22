//
//  Dismissable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

/// Represents something that is dismissable.
/// Typically you'd make a screen that can be dismissed (like a modal) conform to this protocol,
/// and then perform whatever needs to be performed for a dismissal for that screen.
///
/// This works particularly well with NavigationContext.
public protocol Dismissable {
	
	func wait()
	func dismiss()
	
}

public extension Element where Self: Dismissable {
	
	func wait() {
		wait(.exists, .hittable)
	}
	
}
