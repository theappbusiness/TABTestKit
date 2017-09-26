//
//  GlobalFunctions.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 The App Business LTD. All rights reserved.
//

import Foundation
import XCTest

open class GlobalFunctions {
  /**
   Waits for an element to appear and raises a failure if it doesn't appear in the specified time
   
   - parameter explicitElement: Element that's supposed to appear
   - parameter maxDuration:     Maximum wait time
   */
  func waitForElementToAppear(_ element: XCUIElement, maxDuration: Double = 5, file: StaticString = #file, line: UInt = #line) {
    if !element.waitForExistence(timeout: maxDuration) {
      XCTFail("Timed out waiting for element: -\(element)- to appear.", file: file, line: line)
    }
  }
  
  func tapWhenElementAppears(_ element: XCUIElement, maxDuration: Double = 5, file: StaticString = #file, line: UInt = #line) {
    if !element.waitForExistence(timeout: maxDuration) {
      XCTFail("Timed out waiting for element: -\(element)- to appear.", file: file, line: line)
    }
    element.tap()
  }
  
  /**
   Waits for an elemnt to disappear and raises a failure if it doesn't disappear in the specified time
   
   - parameter element:     Element that's supposed to disappear
   - parameter testCase:    Scenario the wait function is called from
   - parameter maxDuration: Eaximum wait time
   */
  func waitForElementToDisappear(_ element: XCUIElement, maxDuration: Double = 5, file: StaticString = #file, line: UInt = #line) {
    if element.waitForExistence(timeout: maxDuration) {
      XCTFail("Timed out waiting for element: -\(element)- to disappear.", file: file, line: line)
    }
  }
  
  /// Takes an x coordinate and a y coordinate and taps them
  ///
  /// - Parameters:
  ///   - xCoordinate: The given coordinate across the x axis
  ///   - yCoordinate: The given coordinate down the y axis
  func tapCoordinate(x xCoordinate: Double, y yCoordinate: Double) {
    //Sets up a base coordinate (the top left of the screen)
    let normalized = App.shared.current().coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
    let coordinate = normalized.withOffset(CGVector(dx: xCoordinate, dy: yCoordinate))
    coordinate.tap()
  }
}
