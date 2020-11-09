//
//  When.swift
//  TABTestKit
//
//  Created by Stefan Renne on 09/11/2020.
//

import XCTest

/// Defines an executable When step to be used in tests.
///
extension XCTestCase {

    // MARK: - Standard init, i.e. When(somethingHappens)

    @discardableResult
    public func When(_ action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return When(action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func When(_ action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["When", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "I" init, i.e. When(I: doSomething)

    @discardableResult
    public func When(I action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return When(I: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func When(I action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["When", "I", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "the" init, i.e. When(the: thingIsTrue)

    @discardableResult
    public func When(the action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return When(the: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func When(the action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["When", "the", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }

    // MARK: - "a" init, i.e. When(a: serverErrorIsReturned)

    @discardableResult
    public func When(a action: () -> StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        return When(a: action(), line: line, function: function, file: file)
    }

    @discardableResult
    public func When(a action: StepAction, line: UInt = #line, function: StaticString = #function, file: StaticString = #file) -> Step {
        let description = ["When", "a", action.description]
            .joined(separator: " ")
        return Step(handler: action.execute, testCase: self, description: description, line: line, function: function, file: file)
    }
}
