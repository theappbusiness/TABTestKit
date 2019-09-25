//
//  OtherElementsScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/09/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import TABTestKit

let otherElementsScreen = OtherElementsScreen()

struct OtherElementsScreen: Screen {
  
  let trait = Header(id: "Other elements")
  let label = Label(id: "Example label")
  let button = Button(id: "Example button")
  let segmentedControl = SegmentedControl(parent: View(id: "ExampleSegmentedControl"))
  let textField = TextField(id: "ExampleTextField")
  let secureTextField = SecureTextField(id: "ExampleSecureTextField")
  let slider = Slider(id: "ExampleSlider")
  let toggle = Switch(id: "ExampleSwitch")
  let stepper = Stepper(id: "ExampleStepper")
  let pageIndicator = PageIndicator(id: "ExamplePageControl")
  let picker = Picker(id: "ExamplePicker")
  
}
