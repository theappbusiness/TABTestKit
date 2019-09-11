//
//  SystemSettingsRootScreen.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//

import XCTest

public let systemPreferencesRootScreen = SystemPreferencesRootScreen()

public struct SystemPreferencesRootScreen: SystemPreferencesScreen, TableDisplaying {
	
	public let trait = Header(id: "Settings", parent: SystemPreferences())
	public var generalCell: Cell {
		return table.cell(matchingID: "General")
	}
	
}
