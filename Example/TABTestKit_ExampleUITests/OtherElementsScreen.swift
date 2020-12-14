//
//  OtherElementsScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/09/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import TABTestKit

let otherElementsScreen = OtherElementsScreen()

struct OtherElementsScreen: Screen {
    
    let trait = Header(id: "Other elements")
    let scrollView = ScrollView(id: "MyScrollView") // In iOS 13, XCUI matches a hidden scroll view when the keyboard is showing :(
    let label = Label(id: "Example label")
    let button = Button(id: "Example button")
    let alertButton = Button(id: "Alert button")
    let segmentedControl = SegmentedControl(parent: View(id: "ExampleSegmentedControl"))
    let textField = TextField(id: "ExampleTextField")
    let numberPadTextField = TextField(id: "NumberPadTextField")
    let decimalPadTextField = TextField(id: "DecimalPadTextField")
    let emailAddressTextField = TextField(id: "EmailAddressTextField")
    let numbersAndPunctuationTextField = TextField(id: "NumbersAndPunctuationTextField")
    let phonePadTextField = TextField(id: "PhonePadTextField")
    let twitterTextField = TextField(id: "TwitterTextField")
    let urlTextField = TextField(id: "URLTextField")
    let webSearchTextField = TextField(id: "WebSearchTextField")
    let secureTextField = SecureTextField(id: "ExampleSecureTextField")
    let slider = Slider(id: "ExampleSlider")
    let toggle = Switch(id: "ExampleSwitch")
    let stepper = Stepper(id: "ExampleStepper")
    let pageIndicator = PageIndicator(id: "ExamplePageControl")
    let image = Image(id: "ExampleImage")
    let picker = Picker(id: "ExamplePicker")
    let timePicker = DatePicker(id: "ExampleTimePicker")
    let datePicker = DatePicker(id: "ExampleDatePicker")
    let dateTimePicker = DatePicker(id: "ExampleDateTimePicker")
    let countdownTimerPicker = DatePicker(id: "ExampleCountDownTimerPicker")
    let shareSheet = ActivitySheet()
    let alert = Alert(id: "Alert title", message: "Alert message", dismissButtonID: "Dismiss")
    
}

extension OtherElementsScreen: Scrollable {
    
    func scroll(_ direction: ElementAttributes.Direction) {
        scrollView.scroll(direction)
    }
    
}
