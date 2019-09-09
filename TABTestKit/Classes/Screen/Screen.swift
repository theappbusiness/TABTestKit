//
//  Screen.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 06/09/2019.
//

import XCTest

public protocol Screen {

	associatedtype Trait: Element
	var trait: Trait { get }

}

extension Screen {
	
	func await() {
		trait.await(.visible, .hittable)
	}
	
}
