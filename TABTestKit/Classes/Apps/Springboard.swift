//
//  Springboard.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public let springboard = Springboard()

/// Represents Springboard.
/// Springboard is esentially the OS, and can display alerts over the whole UI for things like Face ID permission prompts.
public final class Springboard: BaseApp {
	
	public override init() {
		super.init(bundleIdentifier: "com.apple.springboard")
	}

  public override func activate() {
    super.activate()
    sleep(1) // XCUI only waits for our app to idle, not other apps like Springboard, so we'll wait manually.
  }
	
}
