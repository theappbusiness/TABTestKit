//
//  SegmentedControl.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 12/09/2019.
//

import XCTest

public struct SegmentedControl: Element {
	
	public let id: String? = nil // Unfortunately you can't set an ID or label on a segmented control, so we'll just have to reference by index in the parent.
	public let index: Int
	public let parent: Element
	public let type: XCUIElement.ElementType = .segmentedControl
	
	/// Creates a new SegmentedControl.
	/// Unfortunately it's not possibble to give UISegmentedControls an accessibilityLabel or identifier in code,
	/// so you can only find segmented controls by index. Generally there's only one segmented control on a screen anyway,
	/// so for the most part this is unlikely to be an issue.
	///
	/// You could always wrap it in a custom view that has an identifier and set that element as the parent.
	///
	/// - Parameters:
	///   - index: The index of the segmented control. Defaults to 0, meaning the first segmented control.
	///   - parent: The parent element of the SegmentedControl. Defaults to the app.
	public init(index: Int = 0, parent: Element = App.shared) {
		self.index = index
		self.parent = parent
	}
	
	/// Returns a button in the SegmentedControl with the provided ID.
	///
	/// - Parameter buttonID: The ID of the button to find.
	public func button(withID buttonID: String) -> Button {
		return Button(id: buttonID, parent: self)
	}
	
}
