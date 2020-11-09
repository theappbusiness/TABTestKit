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
public protocol Step {

	/// The line in a test function this step is in.
    var line: UInt { get }
	/// The test function this step is in.
    var function: StaticString { get }
	/// The file this step is defined in.
    var file: StaticString { get }
    /// The description of this step.
    var description: String { get }

    init(handler: () -> Void, description: String, line: UInt, function: StaticString, file: StaticString)
}

public extension Step {

    // MARK: - Standard init, i.e. Given(somethingHappens)

    @discardableResult
    init(_ action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        self.init(action(), line: line, function: function, file: file)
    }

    @discardableResult
    init(_ action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        let description = [String(describing: Self.self), action.description].joined(separator: " ")
        self.init(handler: action.execute, description: description, line: line, function: function, file: file)
    }

    // MARK: - "I" init, i.e. Given(I: doSomething)

    @discardableResult
    init(I action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        self.init(I: action(), line: line, function: function, file: file)
    }

    @discardableResult
    init(I action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        let description = [String(describing: Self.self), "I", action.description].joined(separator: " ")
        self.init(handler: action.execute, description: description, line: line, function: function, file: file)
    }

    // MARK: - "the" init, i.e. Given(the: thingIsTrue)

    @discardableResult
    init(the action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        self.init(the: action(), line: line, function: function, file: file)
    }

    @discardableResult
    init(the action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        let description = [String(describing: Self.self), "the", action.description].joined(separator: " ")
        self.init(handler: action.execute, description: description, line: line, function: function, file: file)
    }

    // MARK: - "a" init, i.e. Given(a: serverErrorIsReturned)

    @discardableResult
    init(a action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        self.init(a: action(), line: line, function: function, file: file)
    }

    @discardableResult
    init(a action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) {
        let description = [String(describing: Self.self), "a", action.description].joined(separator: " ")
        self.init(handler: action.execute, description: description, line: line, function: function, file: file)
    }
}
