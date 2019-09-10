//
//  AlertContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol AlertContext {}
public extension AlertContext {
	
	func see(_ alert: Alert) {
		alert.await(.exists, .hittable)
	}
	
	func doNotSee(_ alert: Alert) {
		alert.await(.doesNotExist)
	}
	
	func confirm(_ alert: Alert) {
		alert.confirmButton.tap()
	}
	
	func dismiss(_ alert: Alert) {
		guard let button = alert.dismissButton else { return XCTFail("Cannot dismiss the alert, it has no dismiss button assigned. Did you forget to assign an ID?") }
		button.tap()
	}
	
}
