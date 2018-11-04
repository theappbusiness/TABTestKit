//
//  TestBase.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 The App Business LTD. All rights reserved.
//

import XCTest

/// All Features should inherit from this class
open class TestBase: XCTestCase {
  
  /// Provides the setup for appication that happens before each XCTestCase
  open override func setUp() {
    super.setUp()
    continueAfterFailure = false
		Biometrics.unenrolled()
    launchApp()
  }
  
  /// Launches the application with options if needed // TODO: What does this mean "with options if needed"?
  func launchApp() {
    App.shared.launch()
  }
  
  /// Provides the tear down for the application and each XCTestCase
  open override func tearDown() {
    App.shared.terminate()
    super.tearDown()
  }
}
