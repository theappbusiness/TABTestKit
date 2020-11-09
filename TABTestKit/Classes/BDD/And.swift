//
//  And.swift
//  TABTestKit
//
//  Created by Stefan Renne on 09/11/2020.
//

import XCTest

/// Defines an executable And step to be used in tests.
///
extension XCTestCase {

    // MARK: - Standard init, i.e. And(somethingHappens)

    @discardableResult
    public func And(_ action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return And(action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func And(_ action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["And", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "I" init, i.e. And(I: doSomething)

    @discardableResult
    public func And(I action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return And(I: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func And(I action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["And", "I", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "the" init, i.e. And(the: thingIsTrue)

    @discardableResult
    public func And(the action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return And(the: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func And(the action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["And", "the", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "a" init, i.e. And(a: serverErrorIsReturned)

    @discardableResult
    public func And(a action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return And(a: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func And(a action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["And", "a", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }
}
