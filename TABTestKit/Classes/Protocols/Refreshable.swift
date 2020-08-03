//
//  Refreshable.swift
//  TABTestKit
//
//  Created by Anna Piktas on 27/07/2020.
//

import Foundation

/// Represents something that is refreshable.
/// Typically you'd make a screen that can be refreshed conform to this protocol,
/// and then perform whatever needs to be performed for a "happy path" for that screen.
public protocol Refreshable {
	
    func refresh()
	
}
