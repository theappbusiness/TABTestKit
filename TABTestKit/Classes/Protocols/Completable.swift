//
//  Completable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

/// Represents something that is completable.
/// Typically you'd make a screen that can be completed conform to this protocol,
/// and then perform whatever needs to be performed for a "happy path" for that screen.
///
/// This works particularly well with NavigationContext.
public protocol Completable {

	func await()
	func complete()

}
