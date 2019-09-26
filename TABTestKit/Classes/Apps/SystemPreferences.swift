//
//  SystemPreferences.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents the System Preferences app.
public final class SystemPreferences: BaseApp {
	
	public override init() {
		super.init(bundleIdentifier: "com.apple.Preferences")
	}
	
}
