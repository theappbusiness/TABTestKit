//
//  Step.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Kane Cheshire on 25/07/2018.
//

import XCTest

/// Defines an executable step to be used in tests.
///
/// Steps that are initialised with a function that doesn't take arguments can omit the parenthesis,
/// i.e: Given(I: logIn) instead of Given(I: logIn())
///
/// Do not use this Step type directly, instead use one of the typealiases above, like Given, When, Then or And.
/// To learn more about how to use a Step read this article: https://medium.com/kinandcartacreated/swifty-gherkins-part-1-28abba7dfd8
open class Step {
	
	/// A reference to the most recently created Step, useful if you want to find out what step failed.
	public static var current: Step?
	/// The test case this step is executed in.
    public let testCase: XCTestCase
    /// The line in a test function this step is in.
	public let line: UInt
	/// The test function this step is in.
	public let function: StaticString
	/// The file this step is defined in.
	public let file: StaticString
    /// The description of this step.
    public let description: String

    init(handler: () -> Void, testCase: XCTestCase, description: String, line: UInt, function: StaticString, file: StaticString) {
        self.testCase = testCase
        self.line = line
        self.function = function
        self.file = file
        self.description = description
        Step.current = self

        XCTContext.runActivity(named: description) { _ in

            if App.shared.screenshotOption.contains(.beforeStep) {
                testCase.attachScreenshot()
            }

            handler()

            if App.shared.screenshotOption.contains(.afterStep) {
                testCase.attachScreenshot()
            }
        }
    }
}
