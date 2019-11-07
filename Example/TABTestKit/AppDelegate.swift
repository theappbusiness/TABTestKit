//
//  AppDelegate.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 09/14/2017.
//  Copyright (c) 2017 Zachary Borrelli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    forceSoftwareKeyboard()
    return true
  }
  
  private func forceSoftwareKeyboard() {
    #if targetEnvironment(simulator)
    let setHardwareLayout = NSSelectorFromString("setHardwareLayout:")
    UITextInputMode.activeInputModes.forEach { inputMode in
      guard inputMode.responds(to: setHardwareLayout) else { return }
      inputMode.perform(setHardwareLayout, with: nil)
    }
    #endif
  }
  
}

