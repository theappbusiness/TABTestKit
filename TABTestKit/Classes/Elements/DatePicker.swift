//
//  DatePicker.swift
//  TABTestKit
//
//  Created by Roger Tan on 12/08/2020.
//

import XCTest

/// Represents a DatePicker (UIDatePicker on iOS).
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
    
    /// Returns the wheel for the given index.
    ///
    /// - Parameter index: The index (starting at 0) of the wheel you want to retrieve.
    /// - Returns: The wheel at the provided index.
    public func wheel(_ index: Int) -> Wheel {
        return Wheel(index: index, picker: self)
    }
    
}

public extension DatePicker {

    /// Represents a wheel in a UIDatePicker. You can create these yourselves, but it's
    /// recommended to create a DatePicker instead and ask it for the wheels.
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
            guard newValue != value else { XCTFatalFail("Date Picker is already in state \(newValue)") }
            underlyingXCUIElement.adjust(toPickerWheelValue: newValue)
        }

    }

}
