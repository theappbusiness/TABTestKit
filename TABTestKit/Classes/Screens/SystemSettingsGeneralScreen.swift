//
//  SystemSettingsGeneralScreen.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

public let systemPreferencesGeneralScreen = SystemPreferencesGeneralScreen()

public struct SystemPreferencesGeneralScreen: Screen {
	
	public let trait = Header(id: "General", parent: SystemPreferences())
	public let table = Table(parent: SystemPreferences())
	public var resetCell: Cell {
		return table.cell(matchingID: "Reset")
	}
	
}
