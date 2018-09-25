//
//  Scenario.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Kane Cheshire on 25/07/2018.
//

import XCTest

/// Describes the behaviour of a set of steps.
public struct Scenario {
  
  @discardableResult
  public init(_ description: String, _ handler: () -> Void) {
    XCTContext.runActivity(named: description) { _ in
      handler()
    }
  }
  
}

