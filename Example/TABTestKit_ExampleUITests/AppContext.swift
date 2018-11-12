//
//  AppContext.swift
//  TABTestKit_ExampleUITests
//
//  Created by Suyash Srijan on 05/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import TABTestKit

protocol AppContext {}
extension AppContext {
  
  func backgroundTheApp() {
    XCUIDevice.shared.press(.home)
  }
  
  func foregroundTheApp() {
    App.shared.activate()
  }
}
