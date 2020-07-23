//
//  Step.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Kane Cheshire on 25/07/2018.
//

import Foundation

public typealias Given = Step
public typealias When = Step
public typealias Then = Step
public typealias And = Step

/// Defines an executable step to be used in tests.
///
/// Steps that are initialised with a function that doesn't take arguments can omit the parenthesis,
/// i.e: Given(I: logIn) instead of Given(I: logIn())
///
/// Do not use this Step type directly, instead use one of the typealiases above, like Given, When, Then or And.
/// To learn more about how to use a Step read this article: https://medium.com/kinandcartacreated/swifty-gherkins-part-1-28abba7dfd8
public struct Step {
	
	/// A reference to the most recently created Step, useful if you want to find out what step failed.
	public static var current: Step?
	/// The line in a test function this step is in.
	public let line: UInt
	/// The test function this step is in.
	public let function: StaticString
	/// The file this step is defined in.
	public let file: StaticString
	
	// MARK: - Standard init, i.e. Given(somethingHappens)
	
	@discardableResult
	public init(_ handler: () -> Void, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	@discardableResult
	public init(_ handler: @autoclosure () -> Void, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	// MARK: - "I" init, i.e. Given(I: doSomething)
	
	@discardableResult
	public init(I handler: () -> Void, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	@discardableResult
	public init(I handler: @autoclosure () -> Void, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	// MARK: - "the" init, i.e. Given(the: thingIsTrue)
	
	@discardableResult
	public init(the handler: () -> Void, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	@discardableResult
	public init(the handler: @autoclosure () -> Void, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	// MARK: - "a" init, i.e. Given(a: serverErrorIsReturned)
	
	@discardableResult
	init(a handler: @autoclosure () -> Void, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
	@discardableResult
	init(a handler: () -> Void, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
		self.init(handler: handler, line: line, function: function, file: file)
	}
	
}

private extension Step {
	
	init(handler: () -> Void, line: UInt, function: StaticString, file: StaticString) {
		self.line = line
		self.function = function
		self.file = file
		Step.current = self
		handler()
	}
	
	init(handler: @autoclosure () -> Void, line: UInt, function: StaticString, file: StaticString) {
		self.line = line
		self.function = function
		self.file = file
		Step.current = self
		handler()
	}
	
}
