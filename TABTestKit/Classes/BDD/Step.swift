//
//  Step.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Kane Cheshire on 25/07/2018.
//

import Foundation

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

    init(handler: () -> StepAction, line: UInt, function: StaticString, file: StaticString) {
        self.line = line
        self.function = function
        self.file = file
        Step.current = self
        handler().execute()
    }

    init(handler: @autoclosure () -> StepAction, line: UInt, function: StaticString, file: StaticString) {
        self.line = line
        self.function = function
        self.file = file
        Step.current = self
        handler().execute()
    }

	// MARK: - Standard init, i.e. Given(somethingHappens)
	
	@discardableResult
	public convenience init(_ handler: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	@discardableResult
	public convenience init(_ handler: @autoclosure () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	// MARK: - "I" init, i.e. Given(I: doSomething)
	
	@discardableResult
	public convenience init(I handler: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	@discardableResult
	public convenience init(I handler: @autoclosure () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	// MARK: - "the" init, i.e. Given(the: thingIsTrue)
	
	@discardableResult
	public convenience init(the handler: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	@discardableResult
	public convenience init(the handler: @autoclosure () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	// MARK: - "a" init, i.e. Given(a: serverErrorIsReturned)
	
	@discardableResult
    convenience init(a handler: @autoclosure () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	@discardableResult
    convenience init(a handler: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
}
