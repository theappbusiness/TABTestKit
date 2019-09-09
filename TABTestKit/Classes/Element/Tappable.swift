//
//  Tappable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol Tappable {
	
	func tap()
	
}

public extension Element where Self: Tappable {
	
	func tap() {
		await(.exists, .hittable)
		underlyingXCUIElement.tap()
	}
	
}


