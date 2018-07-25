//
//  App.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 The App Business LTD. All rights reserved.
//

import XCTest

/**
Singleton in charge of creating XCUIApplication instance and managing the global app state,
This is created so the same application instance can be used accross different pages of the app and
the instance we are calling is the one that got launched.
*/
public final class App: XCUIApplication {
	
	public static let shared = App()
	
	private override init () {
		super.init()
	}
}
