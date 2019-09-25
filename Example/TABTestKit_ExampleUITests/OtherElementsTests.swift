//
//  OtherElementsTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/09/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import TABTestKit

final class OtherElementsTests: TABTestCase, SystemPreferencesContext {
  
  override func preLaunchSetup(_ launch: @escaping () -> Void) {
    resetAllPrivacyPrompts()
    launch()
  }
  
  func test_otherElements() {
    Scenario("Navigating to the screen with other elements") {
      Given(I: complete(biometricLoginScreen))
      And(I: see(tabBarScreen))
      When(I: tap(tabBarScreen.otherTabBarButton))
      Then(I: see(otherElementsScreen))
    }
    
    Scenario("Seeing the label and button") {
      Given(I: see(otherElementsScreen))
      Then(I: see(otherElementsScreen.label))
      And(I: see(otherElementsScreen.button))
      And(I: tap(otherElementsScreen.button))
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
      Then(I: tap(otherElementsScreen.textField))
      And(I: type("Hello world", into: otherElementsScreen.textField))
      And(the: value(of: otherElementsScreen.textField, is: "Hello world"))
    }
    
    Scenario("Seeing and interacting with the secure text field") {
      Given(I: see(otherElementsScreen.secureTextField))
      Then(I: tap(otherElementsScreen.secureTextField))
      And(I: type("Password!", into: otherElementsScreen.secureTextField))
      And(the: value(of: otherElementsScreen.secureTextField, is: "•••••••••"))
    }
    
    Scenario("Seeing and interacting with the slider") {
      Given(I: see(otherElementsScreen.slider))
      Then(I: adjust(otherElementsScreen.slider, to: 1))
      And(the: value(of: otherElementsScreen.slider, is: 1))
      And(I: adjust(otherElementsScreen.slider, to: 0))
      And(the: value(of: otherElementsScreen.slider, is: 0))
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
    
    Scenario("Seeing and interacting with the picker") {
      Given(I: see(otherElementsScreen.picker))
      And(the: value(of: otherElementsScreen.picker.wheel(0), is: "Hello"))
      When(I: adjust(otherElementsScreen.picker.wheel(0), to: "World"))
      Then(the: value(of: otherElementsScreen.picker.wheel(0), is: "World"))
    }
  }
  
}


