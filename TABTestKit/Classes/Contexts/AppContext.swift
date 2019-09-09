//
//  AppContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

public protocol AppContext {}
public extension AppContext {
	
	func backgroundTheApp() {
		App().background()
	}
	
	func foregroundTheApp() {
		App().activate()
	}
	
	func terminateTheApp() {
		App().terminate()
	}
	
	func launchTheApp(clean: Bool) {
		clean ? App().launch(clean: true): App().activate() // Quicker! Doesn't re-install the app, but still launches.
	}
	
	func relaunchTheApp() {
		backgroundTheApp()
		terminateTheApp()
		launchTheApp(clean: false)
	}
	
	func openSafari() {
		Safari().activate()
	}
	
	func openSystemPreferences() {
		SystemPreferences().activate()
	}
	
}
