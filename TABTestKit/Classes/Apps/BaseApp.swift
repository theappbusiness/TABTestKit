//
//  BaseApp.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// The preferred XCUIApplication class for custom app instances to inherit from, so that
/// enhanced behaviours, like waiting for the apps to be in the correct state before continuing
/// after backgrounding/foregrounding.
///
/// Additionally, BaseApp conforms to Element, so any subclasses can be used as parent elements
/// of any other Element.
open class BaseApp: XCUIApplication {

    /// The cached name of the app (derived from the label), which allows you to access the name even if the app is terminated.
    /// The name is cached after the app is launched.
    public private(set) var name = ""

    /// Launches the app, waiting for the state to be running before continuing.
    override open func launch() {
        super.launch()
        XCTAssertTrue(wait(for: .runningForeground, timeout: 60), "Failed waiting for app to become .runningForeground")
        name = label
    }
	
	/// "Backgrounds" the app, waiting for the state to be suspended before continuing.
	open func background() {
		XCUIDevice.shared.press(.home)
		XCTAssertTrue(waitForBackgroundState(timeout: 10), "Failed waiting for app to become either .runningBackground or .runningBackgroundSuspended")
	}
	
	/// Activates/foregrounds the app, waiting for the state to be running before continuing.
	override open func activate() {
		super.activate()
		XCTAssertTrue(wait(for: .runningForeground, timeout: 10), "Failed waiting for app to become .runningForeground")
	}
	
	/// Terminates the app, waiting for the state to be not running before continuing.
	override open func terminate() {
		super.terminate()
		XCTAssertTrue(wait(for: .notRunning, timeout: 10), "Failed waiting for app to become .notRunning")
	}
	
}

extension BaseApp: Element {
	
	public var id: String? { return nil }
	public var type: XCUIElement.ElementType { return .application }
	public var underlyingXCUIElement: XCUIElement { return self }
	
}

private extension BaseApp {

	/// Waits for the application to enter one of the background states (either `.runningBackground` or `.runningBackgroundSuspended`).
	/// This is a fix for both https://github.com/theappbusiness/TABTestKit/issues/67 and https://github.com/theappbusiness/TABTestKit/issues/135
	///
	/// - Parameter timeout: The time to wait before failing.
	/// - Returns: `true` if the application enters one of the background states, `false` otherwise.
	func waitForBackgroundState(timeout: TimeInterval) -> Bool {
		var interval = 0.0
		repeat {
			let isInBackgroundState = wait(for: .runningBackground, timeout: 1) || wait(for: .runningBackgroundSuspended, timeout: 1)
			guard !isInBackgroundState else { return true }
			interval += 1
		} while interval <= timeout
		return false
	}
}
