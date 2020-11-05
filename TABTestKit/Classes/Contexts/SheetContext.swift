//
//  SheetContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

public protocol SheetContext {}
public extension SheetContext {
	
	func tap(_ actionButtonID: String, in sheet: Sheet) -> StepAction {
        StepAction {
            sheet.actionButton(withID: actionButtonID).tap()
        }
	}
	
}
