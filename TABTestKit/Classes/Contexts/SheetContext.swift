//
//  SheetContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

public extension TABTestCase {

	func tap(_ actionButtonID: String, in sheet: Sheet) -> StepAction {
        return StepAction(description: "tap on the \(actionButtonID) button in the sheet") {
            sheet.actionButton(withID: actionButtonID).tap()
        }
	}
	
}
