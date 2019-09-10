//
//  SystemScreen.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

/// Represents a system preferences screen.
public protocol SystemPreferencesScreen: Screen {}
public extension SystemPreferencesScreen {
	
	var app: BaseApp { return SystemPreferences() }
	
}
