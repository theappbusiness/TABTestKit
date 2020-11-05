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
        StepAction {
            App.shared.background()
        }
	}
	
	func foregroundTheApp() -> StepAction {
        StepAction {
            App.shared.activate()
        }
	}
	
	func terminateTheApp() -> StepAction {
        StepAction {
            App.shared.terminate()
        }
	}
	
	func launchTheApp(clean: Bool) -> StepAction {
        StepAction {
            App.shared.launch(clean: clean)
        }
	}
	
	func waitForApp(toBe state: XCUIApplication.State, timeout: TimeInterval = 10) -> StepAction {
        StepAction {
            XCTAssertTrue(App.shared.wait(for: App.shared.state == state, timeout: timeout), "App did not have the right state before the timeout. Expected \(state.rawValue), got \(App.shared.state.rawValue)")
        }
	}
	
	func relaunchTheApp() -> StepAction {
        StepAction {
            backgroundTheApp().execute()
            terminateTheApp().execute()
            launchTheApp(clean: false).execute()
        }
	}
	
	func goBackToTABTestKitExampleApp() -> StepAction {
        StepAction {
            XCTAssertEqual(App.shared.name, "TABTestKit_Example")
        }
	}
	
	func openSafari() -> StepAction { // TODO: Move to Safari context
        StepAction {
            Safari().activate()
        }
	}
	
}
