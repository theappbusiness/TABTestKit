//
//  BasePage.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 The App Business LTD. All rights reserved.
//

import XCTest

public protocol UITestPage: class {
  var trait: XCUIElement { get }
}

public extension UITestPage {
  /// Use primarily to assert that you're on the correct screen - all screens should try to have a trait element.
  /// If the trait is static it can be decalred in the init() function of a page, if you want it to be dynamic you can pass it an element to use as a trait
  func await(maxDuration duration: Double = 5) {
    GlobalFunctions().waitForElementToAppear(trait, maxDuration: duration)
  }
}
