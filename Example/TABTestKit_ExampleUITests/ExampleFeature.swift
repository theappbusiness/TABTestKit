//
//  ExampleFeature.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import TABTestKit

class ExampleFeature: TestBase, AppContext, ExampleContext {
  
  func test_example() {
    Scenario("Backgrounding and foregrounding the app") {
      Given(I: backgroundTheApp)
      When(I: foregroundTheApp)
      Then(I: seeTheExampleScreen)
    }
  }
}
