//
//  ViewController.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public struct ViewController: Element {
	
	public let id: String
	public let type: XCUIElement.ElementType = .other
	
	public init(id: String) {
		self.id = id
	}
	
}
