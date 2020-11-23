//
//  AlertContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol AlertContext {}
public extension AlertContext {
	
	func tap(_ actionButtonID: String, in alert: Alert) -> StepAction {
        return StepAction(description: "tap on the \(actionButtonID) button in the alert") {
            alert.actionButton(withID: actionButtonID).tap()
        }
	}
	
}
