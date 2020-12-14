//
//  OtherElementsTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/09/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import TABTestKit

final class OtherElementsTests: TABTestCase, SystemPreferencesContext {
    
    override func preLaunchSetup(_ launch: @escaping () -> Void) {
        resetAllPrivacyPrompts()
        App.shared.launchEnvironment["TZ"] = "UTC"
        launch()
    }
    
    func test_otherElements() {
        Scenario("Navigating to the screen with other elements") {
            Given(I: complete(biometricLoginScreen))
            And(I: see(tabBarScreen))
            When(I: tap(tabBarScreen.otherTabBarButton))
            Then(I: see(otherElementsScreen))
            And(the: label(of: otherElementsScreen.trait, is: "Other elements"))
        }
        
        Scenario("Seeing the label and button") {
            Given(I: see(otherElementsScreen))
            And(I: see(otherElementsScreen.label))
            And(I: see(otherElementsScreen.button))
            When(I: tap(otherElementsScreen.button))
            Then(I: see(otherElementsScreen.shareSheet))
        }
        
        Scenario("Dismissing the share sheet") {
            Given(I: see(otherElementsScreen.shareSheet))
            When(I: dismiss(otherElementsScreen.shareSheet))
            Then(I: doNotSee(otherElementsScreen.shareSheet))
            And(I: see(otherElementsScreen))
        }
        
        Scenario("Seeing and interacting with the segmented control") {
            Given(I: see(otherElementsScreen.segmentedControl))
            Then(I: tap(otherElementsScreen.segmentedControl.button(withID: "Second")))
            And(the: state(of: otherElementsScreen.segmentedControl.button(withID: "First"), isNot: .selected))
            And(the: state(of: otherElementsScreen.segmentedControl.button(withID: "Second"), is: .selected))
            And(I: tap(otherElementsScreen.segmentedControl.button(withID: "Third")))
            And(the: state(of: otherElementsScreen.segmentedControl.button(withID: "Second"), isNot: .selected))
            And(the: state(of: otherElementsScreen.segmentedControl.button(withID: "Third"), is: .selected))
        }
        
        Scenario("Seeing and interacting with the text field") {
            Given(I: see(otherElementsScreen.textField))
            And(the: state(of: otherElementsScreen.textField, isNot: .hasKeyboardFocus))
            Then(I: tap(otherElementsScreen.textField))
            And(the: state(of: otherElementsScreen.textField, is: .hasKeyboardFocus))
            And(I: type("Hello world", into: otherElementsScreen.textField))
            And(the: value(of: otherElementsScreen.textField, is: "Hello world"))
            And(the: keyboardType(is: .regular))
        }
        
        Scenario("Number pad keyboard type") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.numberPadTextField, is: .hittable))
            When(I: tap(otherElementsScreen.numberPadTextField))
            Then(the: state(of: otherElementsScreen.numberPadTextField, is: .hasKeyboardFocus))
            And(the: keyboardType(is: .numberPad))
        }
        
        Scenario("Decimal pad keyboard type") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.decimalPadTextField, is: .hittable))
            When(I: tap(otherElementsScreen.decimalPadTextField))
            Then(the: state(of: otherElementsScreen.decimalPadTextField, is: .hasKeyboardFocus))
            And(the: keyboardType(is: .decimalPad))
        }
        
        Scenario("Email address keyboard type") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.emailAddressTextField, is: .hittable))
            When(I: tap(otherElementsScreen.emailAddressTextField))
            Then(the: state(of: otherElementsScreen.emailAddressTextField, is: .hasKeyboardFocus))
            And(the: keyboardType(is: .emailAddress))
        }
        
        Scenario("Numbers and punctuation keyboard type") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.numbersAndPunctuationTextField, is: .hittable))
            When(I: tap(otherElementsScreen.numbersAndPunctuationTextField))
            Then(the: state(of: otherElementsScreen.numbersAndPunctuationTextField, is: .hasKeyboardFocus))
            And(the: keyboardType(is: .numbersAndPunctuation))
        }
        
        Scenario("Phone pad keyboard type") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.phonePadTextField, is: .hittable))
            When(I: tap(otherElementsScreen.phonePadTextField))
            Then(the: state(of: otherElementsScreen.phonePadTextField, is: .hasKeyboardFocus))
            And(the: keyboardType(is: .phonePad))
        }
        
        Scenario("Twitter keyboard type") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.twitterTextField, is: .hittable))
            When(I: tap(otherElementsScreen.twitterTextField))
            Then(the: state(of: otherElementsScreen.twitterTextField, is: .hasKeyboardFocus))
            And(the: keyboardType(is: .twitter))
        }
        
        Scenario("URL keyboard type") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.urlTextField, is: .hittable))
            When(I: tap(otherElementsScreen.urlTextField))
            Then(the: state(of: otherElementsScreen.urlTextField, is: .hasKeyboardFocus))
            And(the: keyboardType(is: .url))
        }
        
        Scenario("Web search keyboard type") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.webSearchTextField, is: .hittable))
            When(I: tap(otherElementsScreen.webSearchTextField))
            Then(the: state(of: otherElementsScreen.webSearchTextField, is: .hasKeyboardFocus))
            And(the: keyboardType(is: .webSearch))
        }
        
        Scenario("Seeing and interacting with the secure text field") {
            Given(I: see(otherElementsScreen.secureTextField))
            And(the: state(of: otherElementsScreen.secureTextField, isNot: .hasKeyboardFocus))
            Then(I: tap(otherElementsScreen.secureTextField))
            And(the: state(of: otherElementsScreen.secureTextField, is: .hasKeyboardFocus))
            And(I: type("Password!", into: otherElementsScreen.secureTextField))
            And(the: value(of: otherElementsScreen.secureTextField, is: "•••••••••"))
        }
        
        Scenario("Seeing and interacting with the slider") {
            Given(I: tap(keyboard.key("return", isActuallyButton: true)))
            And(I: see(otherElementsScreen.slider))
            When(I: adjust(otherElementsScreen.slider, to: 1))
            Then(I: adjust(otherElementsScreen.slider, to: 0))
        }
        
        Scenario("Seeing and interacting with the switch") {
            Given(I: see(otherElementsScreen.toggle))
            And(the: value(of: otherElementsScreen.toggle, is: .on))
            Then(I: adjust(otherElementsScreen.toggle, to: .off))
            And(the: value(of: otherElementsScreen.toggle, is: .off))
        }
        
        Scenario("Seeing and interacting with the stepper") {
            Given(I: see(otherElementsScreen.stepper))
            And(the: state(of: otherElementsScreen.stepper.decrementButton, isNot: .enabled))
            And(the: state(of: otherElementsScreen.stepper.incrementButton, is: .enabled))
            Then(I: tap(otherElementsScreen.stepper.incrementButton))
            And(the: state(of: otherElementsScreen.stepper.decrementButton, is: .enabled))
            And(the: state(of: otherElementsScreen.stepper.incrementButton, is: .enabled))
            And(I: tap(otherElementsScreen.stepper.incrementButton))
            And(the: state(of: otherElementsScreen.stepper.decrementButton, is: .enabled))
            And(the: state(of: otherElementsScreen.stepper.incrementButton, isNot: .enabled))
        }
        
        Scenario("Seeing and interacting with the page indicator") {
            Given(I: see(otherElementsScreen.pageIndicator))
            Then(the: value(of: otherElementsScreen.pageIndicator, is: "page 1 of 3"))
        }
        
        Scenario("Seeing the image") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.picker, is: .visible))
            When(I: see(otherElementsScreen.image))
            Then(the: value(of: otherElementsScreen.image, is: "Ottoman"))
        }
        
        Scenario("Seeing and interacting with the picker") {
            Given(I: see(otherElementsScreen.picker))
            And(the: value(of: otherElementsScreen.picker.wheel(0), is: "Hello"))
            When(I: adjust(otherElementsScreen.picker.wheel(0), to: "World"))
            Then(the: value(of: otherElementsScreen.picker.wheel(0), is: "World"))
        }
        
        Scenario("Seeing and interacting with the time picker") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.timePicker, is: .visible))
            And(I: see(otherElementsScreen.timePicker))
            And(the: value(of: otherElementsScreen.timePicker.wheel(0), is: "9 o’clock"))
            When(I: adjust(otherElementsScreen.timePicker.wheel(0), to: "10"))
            Then(the: value(of: otherElementsScreen.timePicker.wheel(0), is: "10 o’clock"))
        }
        
        Scenario("Interacting with the time picker for minutes") {
            Given(I: see(otherElementsScreen.timePicker))
            And(the: value(of: otherElementsScreen.timePicker.wheel(1), is: "41 minutes"))
            When(I: adjust(otherElementsScreen.timePicker.wheel(1), to: "42"))
            Then(the: value(of: otherElementsScreen.timePicker.wheel(1), is: "42 minutes"))
        }
        
        Scenario("Interacting with the time picker for period") {
            Given(I: see(otherElementsScreen.timePicker))
            And(the: value(of: otherElementsScreen.timePicker.wheel(2), is: "AM"))
            When(I: adjust(otherElementsScreen.timePicker.wheel(2), to: "PM"))
            Then(the: value(of: otherElementsScreen.timePicker.wheel(2), is: "PM"))
        }
        
        Scenario("Seeing and interacting with the date picker") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.datePicker, is: .visible))
            And(I: see(otherElementsScreen.datePicker))
            And(the: value(of: otherElementsScreen.datePicker.wheel(0), is: "January"))
            When(I: adjust(otherElementsScreen.datePicker.wheel(0), to: "February"))
            Then(the: value(of: otherElementsScreen.datePicker.wheel(0), is: "February"))
        }
        
        Scenario("Interacting with the date picker for day") {
            Given(I: see(otherElementsScreen.datePicker))
            And(the: value(of: otherElementsScreen.datePicker.wheel(1), is: "9"))
            When(I: adjust(otherElementsScreen.datePicker.wheel(1), to: "10"))
            Then(the: value(of: otherElementsScreen.datePicker.wheel(1), is: "10"))
        }
        
        Scenario("Interacting with the date picker for year") {
            Given(I: see(otherElementsScreen.datePicker))
            And(the: value(of: otherElementsScreen.datePicker.wheel(2), is: "2007"))
            When(I: adjust(otherElementsScreen.datePicker.wheel(2), to: "2020"))
            Then(the: value(of: otherElementsScreen.datePicker.wheel(2), is: "2020"))
        }
        
        Scenario("Seeing and interacting with the date time picker") {
            Given(I: scroll(otherElementsScreen, .downwards, until: otherElementsScreen.dateTimePicker, is: .visible))
            And(I: see(otherElementsScreen.datePicker))
            And(the: value(of: otherElementsScreen.dateTimePicker.wheel(0), is: "Tue, Jan 9"))
            When(I: adjust(otherElementsScreen.dateTimePicker.wheel(0), to: "Jan 10"))
            Then(the: value(of: otherElementsScreen.dateTimePicker.wheel(0), is: "Wed, Jan 10"))
        }
        
        Scenario("Interacting with the date time picker for hour") {
            Given(I: see(otherElementsScreen.dateTimePicker))
            And(the: value(of: otherElementsScreen.dateTimePicker.wheel(1), is: "9 o’clock"))
            When(I: adjust(otherElementsScreen.dateTimePicker.wheel(1), to: "10"))
            Then(the: value(of: otherElementsScreen.dateTimePicker.wheel(1), is: "10 o’clock"))
        }
        
        Scenario("Interacting with the date time picker for minute") {
            Given(I: see(otherElementsScreen.dateTimePicker))
            And(the: value(of: otherElementsScreen.dateTimePicker.wheel(2), is: "41 minutes"))
            When(I: adjust(otherElementsScreen.dateTimePicker.wheel(2), to: "42"))
            Then(the: value(of: otherElementsScreen.dateTimePicker.wheel(2), is: "42 minutes"))
        }
        
        Scenario("Interacting with the date time picker for period") {
            Given(I: see(otherElementsScreen.dateTimePicker))
            And(the: value(of: otherElementsScreen.dateTimePicker.wheel(3), is: "AM"))
            When(I: adjust(otherElementsScreen.dateTimePicker.wheel(3), to: "PM"))
            Then(the: value(of: otherElementsScreen.dateTimePicker.wheel(3), is: "PM"))
        }

        Scenario("Seeing and interacting with the count down timer picker") {
            Given(I: scroll(otherElementsScreen, .from(CGVector(dx: 0.95, dy: 0.8), to: CGVector(dx: 0.95, dy: 0.3)), until: otherElementsScreen.countdownTimerPicker, is: .visible)) // We need to scroll down on the edge of the screen, otherwise it will scroll one of the picker.
            And(I: see(otherElementsScreen.countdownTimerPicker))
            And(the: value(of: otherElementsScreen.countdownTimerPicker.wheel(0), is: "0 hours"))
            When(I: adjust(otherElementsScreen.countdownTimerPicker.wheel(0), to: "1"))
            Then(the: value(of: otherElementsScreen.countdownTimerPicker.wheel(0), is: "1 hour"))
        }
        
        Scenario("Interacting with the date time picker for hour") {
            Given(I: see(otherElementsScreen.countdownTimerPicker))
            And(the: value(of: otherElementsScreen.countdownTimerPicker.wheel(1), is: "1 min"))
            When(I: adjust(otherElementsScreen.countdownTimerPicker.wheel(1), to: "59"))
            Then(the: value(of: otherElementsScreen.countdownTimerPicker.wheel(1), is: "59 min"))
        }
    }
    
}


