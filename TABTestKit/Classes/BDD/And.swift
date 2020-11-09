//
//  And.swift
//  TABTestKit
//
//  Created by Stefan Renne on 09/11/2020.
//

import XCTest

public struct And: Step {
    
    /// The line in a test function this step is in.
    public let line: UInt
    /// The test function this step is in.
    public let function: StaticString
    /// The file this step is defined in.
    public let file: StaticString
    /// The description of this step.
    public let description: String

    public init(handler: () -> Void, description: String, line: UInt, function: StaticString, file: StaticString) {
        self.line = line
        self.function = function
        self.file = file
        self.description = description
        TABTestCase.currentStep = self
        XCTContext.runActivity(named: description) { _ in

            TABTestCase.current?.createScreenshotIfNeeded(for: .beforeStep)

            handler()

            TABTestCase.current?.createScreenshotIfNeeded(for: .afterStep)
        }
    }
}
