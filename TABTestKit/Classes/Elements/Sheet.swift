//
//  Sheet.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//

import XCTest

public struct Sheet: Element {
	
	public let id: String?
	public let type: XCUIElement.ElementType = .sheet
	public let parent: Element
	public var dismissButton: Button {
		return Button(id: dismissButtonID, parent: self)
	}
	
	private let dismissButtonID: String
	
	public init(id: String, parent: Element = App.shared, dismissButtonID: String = "Cancel") {
		self.id = id
		self.parent = parent
		self.dismissButtonID = dismissButtonID
	}
	
	public func actionButton(withID actionButtonID: String) -> Button {
		return Button(id: actionButtonID, parent: self)
	}
	
}

extension Sheet: Dismissable {
	
	public func dismiss() {
		dismissButton.tap()
	}
	
}
