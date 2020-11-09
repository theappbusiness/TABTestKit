//
//  Then.swift
//  TABTestKit
//
//  Created by Stefan Renne on 09/11/2020.
//

import XCTest

/// Defines an executable Then step to be used in tests.
///
extension XCTestCase {

    // MARK: - Standard init, i.e. Then(somethingHappens)

    @discardableResult
    public func Then(_ action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return Then(action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func Then(_ action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["Then", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "I" init, i.e. Then(I: doSomething)

    @discardableResult
    public func Then(I action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return Then(I: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func Then(I action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["Then", "I", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "the" init, i.e. Then(the: thingIsTrue)

    @discardableResult
    public func Then(the action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return Then(the: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func Then(the action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["Then", "the", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "a" init, i.e. Then(a: serverErrorIsReturned)

    @discardableResult
    public func Then(a action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return Then(a: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func Then(a action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["Then", "a", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }
}
