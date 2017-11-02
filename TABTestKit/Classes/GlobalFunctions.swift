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
  /// Waits for an element to appear and raises a failure if it doesn't appear in the specified time
  ///
  /// - Parameters:
  ///   - element: element to wait for
  ///   - maxDuration: maximum wait time
  func waitForElementToAppear(_ element: XCUIElement, maxDuration: Double = 5, file: StaticString = #file, line: UInt = #line) {
    if !element.waitForExistence(timeout: maxDuration) && !element.isHittable {
      XCTFail("Timed out waiting for element: -\(element)- to appear.", file: file, line: line)
    }
  }
  
  /// Waits for an element to appear and then taps it
  ///
  /// - Parameters:
  ///   - element: Element to wait for and tap
  func tapWhenElementAppears(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
    waitForElementToAppear(element)
    element.tap()
  }
  
  /// Waits for an elemnt to disappear and raises a failure if it doesn't disappear in the specified time
  ///
  /// - Parameters:
  ///   - element: element to wait to disappear
  ///   - maxDuration: maximum wait time
  func waitForElementToDisappear(_ element: XCUIElement, maxDuration: Double = 5, file: StaticString = #file, line: UInt = #line) {
    if element.waitForExistence(timeout: maxDuration) && element.isHittable {
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
    let normalized = App.shared.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
    let coordinate = normalized.withOffset(CGVector(dx: xCoordinate, dy: yCoordinate))
    coordinate.tap()
  }
}
