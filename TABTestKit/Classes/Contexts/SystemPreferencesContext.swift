//
//  SystemPreferencesContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

public protocol SystemPreferencesContext {}
public extension SystemPreferencesContext {
	
	func resetAllPrivacyPrompts() {
		if SystemPreferences().state != .notRunning {
			openSystemPreferences() // Turns out you can't terminate an app if it's not in the foreground, but we want to terminate it so that it can be reset back to the start, so we're weirdly activating it here before doing anything. Might be a bug.			
		}
		terminateSystemPreferences()
		openSystemPreferences()
		systemPreferencesRootScreen.generalCell.tap()
		systemPreferencesGeneralScreen.resetCell.tap()
		systemPreferencesResetScreen.resetCell.tap()
		systemPreferencesResetScreen.confirmResetSheet.actionButton(withID: "Reset Warnings").tap()
	}
	
	func openSystemPreferences() {
		SystemPreferences().activate()
	}
	
	func terminateSystemPreferences() {
		SystemPreferences().terminate()
	}
	
}
