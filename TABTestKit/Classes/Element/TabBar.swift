//
//  TabBar.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Repreesnts the UITabBar/
public struct TabBar: Element {
	
	public let id: String
	public let type: XCUIElement.ElementType = .tabBar
	var underlyingXCUIElement: XCUIElement { id.isEmpty ? parent.tabBars.firstMatch : parent.tabBars[id].firstMatch } // TODO: Check this actually works
	
	public init(id: String = "") {
		self.id = id
	}
	
}

public extension TabBar {
	
	struct Button: Element, Tappable {
		
		public let id: String
		public let type: XCUIElement.ElementType = .button
		public let parent: XCUIElement
		
		public init(id: String, tabBar: TabBar = TabBar()) {
			self.id = id
			self.parent = tabBar.underlyingXCUIElement
		}
		
	}
	
}
