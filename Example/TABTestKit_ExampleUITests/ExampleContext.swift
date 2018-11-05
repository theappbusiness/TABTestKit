//
//  ExampleContext.swift
//  TABTestKit_ExampleUITests
//
//  Created by Suyash Srijan on 05/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

import XCTest
import TABTestKit

protocol ExampleContext {}
extension ExampleContext where Self: TestBase {
  
  func seeTheExampleScreen() {
    ExampleScreen.shared.await()
  }
  
  func acceptFaceIDAuthenticationPromptIfRequired() {
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    let okayButton = springboard.alerts.buttons["OK"].firstMatch
    guard okayButton.exists else { return }
    okayButton.tap()
  }
}
