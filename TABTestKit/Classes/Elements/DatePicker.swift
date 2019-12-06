//
//  DatePicker.swift
//  Pods-TABTestKit_Example
//
//  Created by Annie Fung on 06/12/2019.
//

import XCTest

/// Represents a datepicker.
/// To interact with the wheels you must first
/// ask the picker for one of it's wheels, by index.

public struct DatePicker: Element {
	
	public let id: String?
	public let index: Int
	public let parent: Element
	public let type: XCUIElement.ElementType = .datePicker
	
	/// Returns the number of wheels the picker contains.
	public var numberOfWheels: Int { return underlyingXCUIElement.pickerWheels.count }
	
	public init(id: String, index: Int = 0, parent: Element = App.shared) {
		self.id = id
		self.index = index
		self.parent = parent
	}
	
	public func wheel(_ index: Int) -> Wheel {
		return Wheel(index: index, picker: self)
	}
}

public extension DatePicker {
	
	struct Wheel: Element, ValueRepresentable, Adjustable {
		
		public let id: String? = nil
		public let index: Int
		public let parent: Element
		public let type: XCUIElement.ElementType = .pickerWheel
		public var value: String { return underlyingXCUIElement.value as? String ?? "" }
		
		public init(index: Int, picker: DatePicker) {
			self.index = index
			self.parent = picker
		}
		
		public func adjust(to newValue: String) {
			underlyingXCUIElement.adjust(toPickerWheelValue: newValue)
		}
		
	}
	
}

