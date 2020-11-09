//
//  Given.swift
//  TABTestKit
//
//  Created by Stefan Renne on 09/11/2020.
//

import XCTest

/// Defines an executable Given step to be used in tests.
///
extension XCTestCase {

    // MARK: - Standard init, i.e. Given(somethingHappens)

    @discardableResult
    public func Given(_ action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return Given(action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func Given(_ action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["Given", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "I" init, i.e. Given(I: doSomething)

    @discardableResult
    public func Given(I action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return Given(I: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func Given(I action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["Given", "I", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "the" init, i.e. Given(the: thingIsTrue)

    @discardableResult
    public func Given(the action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return Given(the: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func Given(the action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["Given", "the", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "a" init, i.e. Given(a: serverErrorIsReturned)

    @discardableResult
    public func Given(a action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return Given(a: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func Given(a action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["Given", "a", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }
}
