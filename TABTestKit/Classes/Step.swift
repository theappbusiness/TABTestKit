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
/// To learn more about how to use a Step read this article: https://edit.theappbusiness.com/swifty-gherkins-part-1-28abba7dfd8
public struct Step {
  
  @discardableResult
  public init(_ handler: () -> Void, function: StaticString = #function) {
    handler()
  }
  
  @discardableResult
  public init(_ handler: @autoclosure () -> Void, function: StaticString = #function) {
    handler()
  }
  
  @discardableResult
  public init(I handler: () -> Void, function: StaticString = #function) {
    handler()
  }
  
  @discardableResult
  public init(I handler: @autoclosure () -> Void, function: StaticString = #function) {
    handler()
  }
  
  @discardableResult
  public init(the handler: () -> Void, function: StaticString = #function) {
    handler()
  }
  
  @discardableResult
  public init(the handler: @autoclosure () -> Void, function: StaticString = #function) {
    handler()
  }
  
}
