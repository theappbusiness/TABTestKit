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

/// Singleton in charge of creating XCUIApplication instance and managing the global app state,
/// This is created so the same application instance can be used accross different pages of the app and
/// the instance we are calling is the one that got launched.
///
/// Using this instance also ensures that the app is in the right state after activating/terminating etc before continuing.
public final class App: XCUIApplication {
  
  public static let shared = App()
  
  private override init () { super.init() }
	
	/// Terminates the app, waiting for the state to be not running before continuing.
	override public func terminate() {
		super.terminate()
		XCTAssert(wait(for: .notRunning, timeout: 10))
	}
	
	/// Activates/foregrounds the app, waiting for the state to be running before continuing.
	override public func activate() {
		super.activate()
		XCTAssert(wait(for: .runningForeground, timeout: 10))
	}
	
	/// Launches the app, cleaning if required.
	public func launch(clean shouldClean: Bool) {
		if shouldClean {
			launchArguments.append("TABTestKit.Clean")
		} else {
			launchArguments.removeAll { $0 == "TABTestKit.Clean" }
		}
		super.launch()
		XCTAssert(wait(for: .runningForeground, timeout: 60))
	}
	
	/// "Backgrounds" the app, waiting for the state to be suspended before continuing.
	public func background() {
		XCUIDevice.shared.press(.home)
		XCTAssert(wait(for: .runningBackgroundSuspended, timeout: 10))
	}
	
}
