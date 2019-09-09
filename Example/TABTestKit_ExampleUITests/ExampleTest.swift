//
//  ExampleTest.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import TABTestKit

final class ExampleTest: TABTestCase {
  
  override func preLaunchSetup(_ completion: @escaping () -> Void) {
    print("Doin' something pre-launch here!")
    completion()
  }
  
  func test_example() {
    Scenario("Backgrounding and foregrounding the app") {
      Given(I: backgroundTheApp)
      When(I: foregroundTheApp)
      Then(I: see(exampleScreen))
    }
    
    Scenario("Bumping out to Safari and back to the app") {
      Given(I: openSafari)
      When(I: foregroundTheApp)
      Then(I: see(exampleScreen))
    }
    
    Scenario("Bumping out to System Preferences and back to the app") {
      Given(I: openSystemPreferences)
      When(I: foregroundTheApp)
      Then(I: see(exampleScreen))
    }
    
    Scenario("Terminating and relaunching the app") {
      Given(I: relaunchTheApp())
      Then(I: see(exampleScreen))
    }
  }
}
