//
//  NavBar.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents the UINavigationBar.
public struct NavBar: Element {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .navigationBar
	
	public init(id: String? = nil, parent: Element = App()) {
		self.id = id
		self.parent = parent
	}
	
}
