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
	
	/// Launches the app, waiting for the state to be running before continuing.
	override open func launch() {
		super.launch()
		XCTAssert(wait(for: .runningForeground, timeout: 60))
	}
	
	/// "Backgrounds" the app, waiting for the state to be suspended before continuing.
	open func background() {
		XCUIDevice.shared.press(.home)
		XCTAssert(wait(for: .runningBackgroundSuspended, timeout: 10))
	}
	
	/// Activates/foregrounds the app, waiting for the state to be running before continuing.
	override open func activate() {
		super.activate()
		XCTAssert(wait(for: .runningForeground, timeout: 10))
	}
	
	/// Terminates the app, waiting for the state to be not running before continuing.
	override open func terminate() {
		super.terminate()
		XCTAssert(wait(for: .notRunning, timeout: 10))
	}
	
}

extension BaseApp: Element {
	
	public var id: String? { return nil }
	public var type: XCUIElement.ElementType { return .application }
	public var underlyingXCUIElement: XCUIElement { return self }
	
}
