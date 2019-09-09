//
//  AlertContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

public protocol AlertContext {}
public extension AlertContext {
	
	func see(_ alert: Alert) {
		alert.await(.exists, .hittable) // TODO: Test
	}
	
	func tap(_ button: Alert.Button) {
		button.tap()
	}
	
}
