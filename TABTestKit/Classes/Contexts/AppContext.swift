//
//  AppContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation
import XCTest

public protocol AppContext {}
public extension AppContext {
	
	func backgroundTheApp() {
		App.shared.background()
	}
	
	func foregroundTheApp() {
		App.shared.activate()
	}
	
	func terminateTheApp() {
		App.shared.terminate()
	}
	
	func launchTheApp(clean: Bool) {
		App.shared.launch(clean: clean)
	}
	
	func waitForApp(toBe state: XCUIApplication.State, timeout: TimeInterval = 10) {
		XCTAssertTrue(App.shared.wait(for: App.shared.state == state, timeout: timeout), "App did not have the right state before the timeout. Expected \(state.rawValue), got \(App.shared.state.rawValue)")
	}
	
	func relaunchTheApp() {
		backgroundTheApp()
		terminateTheApp()
		launchTheApp(clean: false)
	}
	
	func goBackToTABTestKitExampleApp() {
		XCTAssertEqual(App.shared.name, "TABTestKit_Example")
	}
	
	func openSafari() { // TODO: Move to Safari context
		Safari().activate()
	}
	
}
