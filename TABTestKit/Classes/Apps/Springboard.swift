//
//  Springboard.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents Springboard.
/// Springboard is esentially the OS, and can display alerts over the whole UI for things like Face ID permission prompts.
public final class Springboard: BaseApp {
	
	public override init() {
		super.init(bundleIdentifier: "com.apple.springboard")
	}
	
}
