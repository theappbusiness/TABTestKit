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
		if #available(iOS 12.4, *) { // https://github.com/theappbusiness/TABTestKit/issues/67
			XCTAssertTrue(wait(for: .runningBackground, timeout: 10), "Failed waiting for app to become .runningBackground")
		} else {
			XCTAssertTrue(wait(for: .runningBackgroundSuspended, timeout: 10), "Failed waiting for app to become .runningBackgroundSuspended")
		}
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
