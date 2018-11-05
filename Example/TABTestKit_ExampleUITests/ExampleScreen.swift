//
//  ExampleScreen.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import TABTestKit

final class ExampleScreen: UITestScreen {
	
  let app: XCUIApplication
  let trait: XCUIElement
  let authenticateButton: XCUIElement
  let authenticateLabel: XCUIElement
  
  static let shared = ExampleScreen()
  
  private init() {
    app = App.shared
    trait = app.staticTexts["Hello world!"]
    authenticateButton = app.buttons.element(matching: .button, identifier: "authenticateButton")
    authenticateLabel = app.staticTexts.element(matching: .any, identifier: "biometricStatusLabel")
  }
	
}
