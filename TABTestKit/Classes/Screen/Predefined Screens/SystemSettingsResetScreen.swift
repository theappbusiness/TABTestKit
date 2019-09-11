//
//  SystemSettingsResetScreen.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

public let systemPreferencesResetScreen = SystemPreferencesResetScreen()

public struct SystemPreferencesResetScreen: SystemPreferencesScreen, TableDisplaying {
	
	public let trait = Header(id: "Reset", parent: SystemPreferences())
	public var resetCell: Cell {
		return table.cell(matchingID: "Reset Location & Privacy")
	}
	public let confirmResetSheet = Sheet(id: "This will reset your location warnings to factory defaults.", parent: SystemPreferences())
	
}
