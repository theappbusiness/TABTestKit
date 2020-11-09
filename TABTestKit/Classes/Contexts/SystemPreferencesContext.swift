//
//  SystemPreferencesContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

public protocol SystemPreferencesContext {}
public extension SystemPreferencesContext {
	
	func resetAllPrivacyPrompts() -> StepAction {
        return StepAction(description: "reset all privacy prompts") {
            if SystemPreferences().state != .notRunning {
                openSystemPreferences().execute() // Turns out you can't terminate an app if it's not in the foreground, but we want to terminate it so that it can be reset back to the start, so we're weirdly activating it here before doing anything. Might be a bug.
            }
            terminateSystemPreferences().execute()
            openSystemPreferences().execute()
            systemPreferencesRootScreen.generalCell.tap()
            systemPreferencesGeneralScreen.resetCell.tap()
            systemPreferencesResetScreen.resetCell.tap()
            systemPreferencesResetScreen.confirmResetSheet.actionButton(withID: "Reset Warnings").tap()
        }
	}
	
	func openSystemPreferences() -> StepAction {
        return StepAction(description: "open system preferences") {
            SystemPreferences().activate()
        }
	}
	
	func terminateSystemPreferences() -> StepAction{
        return StepAction(description: "terminate system preferences") {
            SystemPreferences().terminate()
        }
	}
	
}
