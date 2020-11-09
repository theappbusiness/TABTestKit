//
//  Step.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Kane Cheshire on 25/07/2018.
//

import XCTest

open class Given: Step {}
open class When: Step {}
open class Then: Step {}
open class And: Step {}

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
	/// The line in a test function this step is in.
	public let line: UInt
	/// The test function this step is in.
	public let function: StaticString
	/// The file this step is defined in.
	public let file: StaticString
    /// The description of this step.
    public let description: String

    init(handler: () -> Void, description: String, line: UInt, function: StaticString, file: StaticString) {
        self.line = line
        self.function = function
        self.file = file
        self.description = description
        Step.current = self
        XCTContext.runActivity(named: description) { _ in

            TABTestCase.current?.createScreenshotIfNeeded(for: .beforeStep)

            handler()

            TABTestCase.current?.createScreenshotIfNeeded(for: .afterStep)
        }
    }

	// MARK: - Standard init, i.e. Given(somethingHappens)
	
	@discardableResult
	public convenience init(_ action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        self.init(action(), line: line, function: function, file: file)
	}
	
	@discardableResult
	public convenience init(_ action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        let description = [String(describing: Swift.type(of: self)), action.description]
            .joined(separator: " ")
        self.init(handler: action.execute, description: description, line: line, function: function, file: file)
	}
	
	// MARK: - "I" init, i.e. Given(I: doSomething)
	
	@discardableResult
	public convenience init(I action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(I: action(), line: line, function: function, file: file)
	}
	
	@discardableResult
	public convenience init(I action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        let description = [String(describing: Swift.type(of: self)), "I", action.description]
            .joined(separator: " ")
		self.init(handler: action.execute, description: description, line: line, function: function, file: file)
	}
	
	// MARK: - "the" init, i.e. Given(the: thingIsTrue)
	
	@discardableResult
	public convenience init(the action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(the: action(), line: line, function: function, file: file)
	}
	
	@discardableResult
	public convenience init(the action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        let description = [String(describing: Swift.type(of: self)), "the", action.description]
            .joined(separator: " ")
		self.init(handler: action.execute, description: description, line: line, function: function, file: file)
	}
	
	// MARK: - "a" init, i.e. Given(a: serverErrorIsReturned)

    @discardableResult
    convenience init(a action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        self.init(a: action(), line: line, function: function, file: file)
    }

	@discardableResult
    convenience init(a action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        let description = [String(describing: Swift.type(of: self)), "a", action.description]
            .joined(separator: " ")
		self.init(handler: action.execute, description: description, line: line, function: function, file: file)
	}
	
}
