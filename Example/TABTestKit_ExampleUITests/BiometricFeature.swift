//
//  BiometricFeature.swift
//  TABTestKit_ExampleUITests
//
//  Created by Suyash Srijan on 04/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import TABTestKit

class BiometricFeature: TestBase, AppContext, ExampleContext {
  
  func test_launchWithBiometricsDisabled() {
    Scenario("Launching the app with biometrics disabled") {
      Given(I: acceptFaceIDAuthenticationPromptIfRequired)
      When(I: seeTheExampleScreen)
      Then(I: seeBiometricsUnavailableStatus)
      And(the: authenticateButtonIsDisabled)
    }
  }
  
  func test_biometricsEnabled() {
    Scenario("Launching the app with biometrics disabled, enabling it and performing a successful authentication") {
      Given(I: acceptFaceIDAuthenticationPromptIfRequired)
      And(I: seeTheExampleScreen)
      And(I: seeBiometricsUnavailableStatus)
      And(the: authenticateButtonIsDisabled)
      When(I: performEnrollment)
      And(I: backgroundTheApp)
      And(I: foregroundTheApp)
      And(I: tapAuthenticateButton)
      Then(I: performSuccessfulAuthentication)
    }
  }
}

private extension BiometricFeature {
  
  func performEnrollment() {
    Biometrics.enrolled()
  }
  
  func performUnenrollment() {
    Biometrics.unenrolled()
  }
  
  func tapAuthenticateButton() {
    ExampleScreen.shared.authenticateButton.tap()
  }
  
  func seeTheExampleScreen() {
    ExampleScreen.shared.await()
  }
  
  func performSuccessfulAuthentication() {
    Biometrics.successfulAuthentication()
  }
}

private extension BiometricFeature {
  func seeBiometricsUnavailableStatus() {
    XCTAssertEqual(ExampleScreen.shared.authenticateLabel.label, "Biometrics unavailable")
  }
  
  func authenticateButtonIsDisabled() {
    XCTAssertFalse(ExampleScreen.shared.authenticateButton.isEnabled)
  }
  
  func authenticateButtonIsEnabled() {
    XCTAssertTrue(ExampleScreen.shared.authenticateButton.isEnabled)
  }
  
  func seeBiometricsAvailableStatus() {
    XCTAssertEqual(ExampleScreen.shared.authenticateLabel.label, "Biometrics available")
  }
}
