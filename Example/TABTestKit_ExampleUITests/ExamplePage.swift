//
//  ExamplePage.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import TABTestKit

final class ExamplePage: BasePage, UITestPage {
  let app: XCUIApplication
  let trait: XCUIElement
  
  override init() {
    app = App.shared
    trait = app.staticTexts["Hello world!"]
    super.init()
  }
}
