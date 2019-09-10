//
//  NavBar.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents the UINavigationBar.
public struct NavBar: Element {
	
	public let id: String
	public let type: XCUIElement.ElementType = .navigationBar
	var underlyingXCUIElement: XCUIElement { return id.isEmpty ? parent.navigationBars.firstMatch : parent.navigationBars[id].firstMatch } // TODO: Check this actually works
	
	public init(id: String = "") {
		self.id = id
	}
	
}
