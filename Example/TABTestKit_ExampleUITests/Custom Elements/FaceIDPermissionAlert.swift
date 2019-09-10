//
//  FaceIDPermissionAlert.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import TABTestKit
import XCTest

struct FaceIDPermissionAlert: Element {
  
  let id: String = "Do you want to allow “TABTestKit_Example” to use Face ID?"
  let type: XCUIElement.ElementType = .alert
  let parent: XCUIElement = Springboard()
  let okButton = Button(id: "OK", app: Springboard()) // TODO: Maybe should be able to inject parents into buttons
  
}
