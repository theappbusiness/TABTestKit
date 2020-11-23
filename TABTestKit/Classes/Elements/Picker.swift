//
//  Picker.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 25/09/2019.
//

import XCTest

/// Represents a picker (UIPickerView on iOS).
/// To interact with the wheels you must first
/// ask the picker for one of it's wheels, by index.
public struct Picker: Element {
	
	public let id: String?
	public let index: Int
    public let name: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .picker
	
	/// Returns the number of wheels the picker contains.
	public var numberOfWheels: Int { return underlyingXCUIElement.pickerWheels.count }
	
	public init(id: String, index: Int = 0, name: String? = nil, parent: Element = App.shared) {
		self.id = id
		self.index = index
        self.name = name
		self.parent = parent
	}
	
	/// Returns the wheel for the given index.
	///
	/// - Parameter index: The index (starting at 0) of the wheel you want to retrieve.
	/// - Returns: The wheel at the provided index.
	public func wheel(_ index: Int) -> Wheel {
		return Wheel(index: index, picker: self)
	}
	
}

public extension Picker {
	
	/// Represents a wheel in a Picker. You can create these yourselves, but it's
	/// recommended to create a Picker instead and ask it for the wheels.
	struct Wheel: Element, ValueRepresentable, Adjustable {
		
		public let id: String? = nil
		public let index: Int
		public let parent: Element
		public let type: XCUIElement.ElementType = .pickerWheel
		public var value: String { return underlyingXCUIElement.value as? String ?? "" }
		
		public init(index: Int, picker: Picker) {
			self.index = index
			self.parent = picker
		}
		
		public func adjust(to newValue: String) {
			guard newValue != value else { XCTFatalFail("Picker is already in state \(newValue)") }
			underlyingXCUIElement.adjust(toPickerWheelValue: newValue)
		}
		
	}
	
}
