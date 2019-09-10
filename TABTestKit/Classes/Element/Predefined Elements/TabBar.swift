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
	
	public init(id: String = "") {
		self.id = id
	}
	
}

public extension TabBar {
	
	struct Button: Element, Tappable {
		
		public let id: String
		public let type: XCUIElement.ElementType = .button
		public let parent: Element
		
		public init(id: String, tabBar: TabBar = TabBar()) {
			self.id = id
			self.parent = tabBar
		}
		
	}
	
}
