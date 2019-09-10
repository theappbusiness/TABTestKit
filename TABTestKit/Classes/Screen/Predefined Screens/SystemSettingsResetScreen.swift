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
	public var resetCell: Table.Cell { return .init(id: "Reset Location & Privacy", table: table) }
	public let confirmResetSheet = Sheet(id: "This will reset your location warnings to factory defaults.", parent: SystemPreferences(), actionButtonIDs: ["Reset Warnings"])
	
}
