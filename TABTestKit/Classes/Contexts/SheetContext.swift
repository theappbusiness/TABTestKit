//
//  SheetContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

public protocol SheetContext {}
public extension SheetContext {
	
	func see(_ sheet: Sheet) {
		sheet.await(.exists, .hittable)
	}
	
	func dismiss(_ sheet: Sheet) {
		sheet.dismissButton.tap()
	}
	
	func tap(button index: Int, in sheet: Sheet) {
		sheet.actionButtons[index].tap()
	}
	
}
