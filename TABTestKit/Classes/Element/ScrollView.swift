//
//  ScrollView.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public struct ScrollView: Element, Scrollable {
	
	public let id: String
	public let type: XCUIElement.ElementType = .scrollView
	
	public init(id: String) {
		self.id = id
	}
	
}
