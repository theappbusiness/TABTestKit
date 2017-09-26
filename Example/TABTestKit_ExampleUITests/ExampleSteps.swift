//
//  ExampleSteps.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 15/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import TABTestKit
import XCTest_Gherkin

class ExampleSteps: StepDefiner {
  let examplePage = ExamplePage()
  
  override func defineSteps() {
    step("I have opened the application") {
      self.examplePage.await()
    }
  }
}
