//
//  BaseApp.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

open class BaseApp: XCUIApplication, Element {
	
	public var id: String { return identifier }
	public var type: XCUIElement.ElementType { return .application }
	public var underlyingXCUIElement: XCUIElement { return self }
	
	/// Terminates the app, waiting for the state to be not running before continuing.
	override open func terminate() {
		super.terminate()
		XCTAssert(wait(for: .notRunning, timeout: 10))
	}
	
	/// Activates/foregrounds the app, waiting for the state to be running before continuing.
	override open func activate() {
		super.activate()
		XCTAssert(wait(for: .runningForeground, timeout: 10))
	}
	
	/// "Backgrounds" the app, waiting for the state to be suspended before continuing.
	open func background() {
		XCUIDevice.shared.press(.home)
		XCTAssert(wait(for: .runningBackgroundSuspended, timeout: 10))
	}
	
	/// Launches the app, waiting for the state to be running before continuing.
	override open func launch() {
		super.launch()
		XCTAssert(wait(for: .runningForeground, timeout: 60))
	}
	
}
