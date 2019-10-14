//
//  ScrollableScreen.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 11/10/2019.
//

import Foundation

/// A special protocol that can be conformed to instead of the regular `Screen`,
/// which requires that your `trait` is any `Element` that also conforms to `Scrollable`.
///
/// Any screen that conforms to this protocol are automatically scrollable, and can be used
/// with `InteractionContext` directly.
public protocol ScrollableScreen: Screen & Scrollable where Trait: Scrollable {}

public extension Screen where Trait: Scrollable {
	
	func scroll(_ direction: ElementAttributes.Direction) {
		trait.scroll(direction)
	}
	
}
