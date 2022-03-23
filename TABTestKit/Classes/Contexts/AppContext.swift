//
//  AppContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation
import XCTest

public extension TABTestCase {
	
	func backgroundTheApp() -> StepAction {
        return StepAction(description: "background the app") {
            App.shared.background()
        }
	}
	
	func foregroundTheApp() -> StepAction {
        return StepAction(description: "foreground the app") {
            App.shared.activate()
        }
	}
	
	func terminateTheApp() -> StepAction {
        return StepAction(description: "terminate the app") {
            App.shared.terminate()
        }
	}
	
	func launchTheApp(clean: Bool = true) -> StepAction {
        return StepAction(description: "launch the app") {
            App.shared.launch(clean: clean)
        }
	}
	
	func waitForApp(toBe state: XCUIApplication.State, timeout: TimeInterval = 10) -> StepAction {
        return StepAction(description: "wait for the app to be \(state.description)") {
            XCTAssertTrue(App.shared.wait(for: App.shared.state == state, timeout: timeout), "App did not have the right state before the timeout. Expected \(state.rawValue), got \(App.shared.state.rawValue)")
        }
	}
	
	func relaunchTheApp() -> StepAction {
        return StepAction(description: "relaunch the app") {
            self.backgroundTheApp().execute()
            self.terminateTheApp().execute()
            self.launchTheApp(clean: false).execute()
        }
	}
	
	func openSafari() -> StepAction { // TODO: Move to Safari context
        return StepAction(description: "open safari") {
            Safari().activate()
        }
	}
	
}
