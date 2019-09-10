//
//  SystemSettingsGeneralScreen.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

public let systemPreferencesGeneralScreen = SystemPreferencesGeneralScreen()

public struct SystemPreferencesGeneralScreen: SystemPreferencesScreen, TableDisplaying {
	
	public let trait = Header(id: "General", parent: SystemPreferences())
	public var resetCell: Table.Cell { return .init(id: "Reset", table: table) }
	
}
