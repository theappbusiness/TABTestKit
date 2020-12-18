//
//  BackButtonMenu.swift
//  TABTestKit
//
//  Created by Anna Piktas on 18/12/2020.
//

import XCTest

/// Represents a Back Button Menu element.
/// 	@available(iOS 14.0, *)
public struct BackButtonMenu: Element, Scrollable, Tappable {
	
	public var id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .menuBar
	
	var numberOfItems: Int { return underlyingXCUIElement.descendants(matching: .menuBarItem).count }
	
	public init(id: String, parent: Element = App.shared) {
		self.id = id
		self.parent = parent
	}
	
//	func tapItem(withID id: String) {
//
//	}

}

extension BackButtonMenu {
	
	struct BackButtonMenuItem: Element, Tappable, Scrollable {
		let id: String?
		let type: XCUIElement.ElementType = .menuBarItem
		let parent: Element
		
		init(id: String, parent: BackButtonMenu) {
			self.id = id
			self.parent = parent
		}
		
	}
	
}
