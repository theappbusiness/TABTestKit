//
//  Sheet.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//

import XCTest

public struct Sheet: Element {
	
	public let id: String
	public let type: XCUIElement.ElementType = .sheet
	public let parent: Element
	public var dismissButton: Button {
		return Button(id: dismissButtonID, parent: self)
	}
	public var actionButtons: [Button] {
		return actionButtonIDs.map { Button(id: $0, parent: self) }
	}
	
	private let dismissButtonID: String
	private let actionButtonIDs: [String]
	
	public init(id: String, parent: Element = App(), dismissButtonID: String = "Cancel", actionButtonIDs: [String]) {
		self.id = id
		self.parent = parent
		self.dismissButtonID = dismissButtonID
		self.actionButtonIDs = actionButtonIDs
	}
	
}
