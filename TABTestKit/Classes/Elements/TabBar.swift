//
//  TabBar.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

/// Represents the UITabBar of the app.
/// Since most apps generally just have one tab bar,
/// you don't need to provide an ID, but you can do so
/// if you need to.
public struct TabBar: Element {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .tabBar
	
	/// Creates a new TabBar.
	/// Since most apps generally have just one tab bar,
	/// you don't need to provide an ID, but you can do so
	/// if you need to.
	///
	/// - Parameter id: The ID of the tab bar. Defaults to nil.
	public init(id: String? = nil, parent: Element = App.shared) {
		self.id = id
		self.parent = parent
	}
	
	/// "Vends" a button representing a tab.
	/// Typically the ID is just the title of the button,
	/// but if you've set a custom identifier or label on the buttons
	/// you can use that as the ID instead.
	///
	///
	/// - Parameter buttonID: The ID of the button. Typically the title of the button.
	/// - Returns: A button representing a tab in the tab bar.
	public func button(withID buttonID: String) -> Button {
		return Button(id: buttonID, parent: self)
	}
	
}

extension TabBar {
	
	public var numberOfTabs: Int {
    #if swift(>=5.5)
		  waitFor(.exists, .hittable)
    #else
      await(.exists, .hittable)
    #endif
		return underlyingXCUIElement.buttons.count
	}
	
}
