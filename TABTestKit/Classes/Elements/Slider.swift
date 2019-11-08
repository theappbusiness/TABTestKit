//
//  Slider.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 12/09/2019.
//

import XCTest

public struct Slider: Element, ValueRepresentable, Adjustable {
	
	public let id: String?
	public let index: Int
	public let parent: Element
	public let type: XCUIElement.ElementType = .slider
	public var value: CGFloat { return underlyingXCUIElement.normalizedSliderPosition }
	
	public init(id: String, index: Int = 0, parent: Element = App.shared) {
		self.id = id
		self.index = index
		self.parent = parent
	}
	
	public func adjust(to newValue: CGFloat) {
		guard newValue != value else { XCTFatalFail("Slider is already set to \(newValue)") }
		underlyingXCUIElement.adjust(toNormalizedSliderPosition: newValue)
	}
	
}
