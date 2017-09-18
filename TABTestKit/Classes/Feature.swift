//
//  Feature.swift
//  TABTestKit
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 The App Business LTD. All rights reserved.
//

import XCTest

open class Feature: XCTestCase {
  
  open override func setUp() {
    super.setUp()
    continueAfterFailure = false
    launchApp()
  }
  
  func launchApp() {
    App.shared.launchWithOptions()
  }
  
  open override func tearDown() {
    App.shared.terminate()
    super.tearDown()
  }
}
