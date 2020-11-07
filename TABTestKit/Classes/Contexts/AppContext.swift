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
	
	func backgroundTheApp() -> StepAction {
        StepAction(description: "background the app") {
            App.shared.background()
        }
	}
	
	func foregroundTheApp() -> StepAction {
        StepAction(description: "foreground the app") {
            App.shared.activate()
        }
	}
	
	func terminateTheApp() -> StepAction {
        StepAction(description: "terminate the app") {
            App.shared.terminate()
        }
	}
	
	func launchTheApp(clean: Bool) -> StepAction {
        StepAction(description: "launch the app") {
            App.shared.launch(clean: clean)
        }
	}
	
	func waitForApp(toBe state: XCUIApplication.State, timeout: TimeInterval = 10) -> StepAction {
        StepAction(description: "wait for the app to be \(state.description)") {
            XCTAssertTrue(App.shared.wait(for: App.shared.state == state, timeout: timeout), "App did not have the right state before the timeout. Expected \(state.rawValue), got \(App.shared.state.rawValue)")
        }
	}
	
	func relaunchTheApp() -> StepAction {
        StepAction(description: "relaunch the app") {
            backgroundTheApp().execute()
            terminateTheApp().execute()
            launchTheApp(clean: false).execute()
        }
	}
	
	func goBackToTABTestKitExampleApp() -> StepAction {
        StepAction(description: "go back to the TABTestKit Example app") {
            XCTAssertEqual(App.shared.name, "TABTestKit_Example")
        }
	}
	
	func openSafari() -> StepAction { // TODO: Move to Safari context
        StepAction(description: "open safari") {
            Safari().activate()
        }
	}
	
}
