//
//  Scenario.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Kane Cheshire on 25/07/2018.
//

import XCTest

/// Describes the behaviour of a set of steps.
public struct Scenario {
	
	/// A reference to the most recently created Step, useful if you want to find out what step failed.
	public static var current: Scenario?
	/// The description of this scenario.
	public let description: String
	
	@discardableResult
	public init(_ description: String, _ handler: () -> Void) {
		self.description = description
		Scenario.current = self
		XCTContext.runActivity(named: description) { _ in
			handler()
		}
	}
	
}

