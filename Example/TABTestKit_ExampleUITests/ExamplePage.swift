//
//  ExamplePage.swift
//  TABTestKit
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import TABTestKit

final class ExamplePage: BasePage {
  let app: XCUIApplication
  let trait: XCUIElement
  
  override init() {
    app = App.shared.current()
    trait = app.staticTexts["Hello World!"]
  }
  
  
}
