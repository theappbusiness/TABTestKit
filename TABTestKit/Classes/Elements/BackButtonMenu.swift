//
//  BackButtonMenu.swift
//  TABTestKit
//
//  Created by Anna Piktas on 18/12/2020.
//

import XCTest

// 	@available(iOS 14.0, *)
public struct BackButtonMenu: Element, Scrollable, Tappable {
	
	public var id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .menuBar
	
}
