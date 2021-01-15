//
//  AlertContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol AlertContext {}
public extension AlertContext {
	
	func tap(_ actionButtonID: String, in alert: Alert) {
		alert.actionButton(withID: actionButtonID).tap()
	}
	
	func message(in alert: Alert, is message: String) {
		XCTAssertEqual(alert.message, message)
	}
}
