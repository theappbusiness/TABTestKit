//
//  BiometricFeature.swift
//  TABTestKit_ExampleUITests
//
//  Created by Suyash Srijan on 04/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import TABTestKit

final class BiometricFeature: TABTestCase {
  
  func test_launchWithBiometricsDisabled() {
    Scenario("Launching the app with biometrics disabled") {
      Given(I: acceptFaceIDAuthenticationPromptIfRequired)
      When(I: see(exampleScreen))
      Then(I: seeBiometricsUnavailableStatus)
      And(the: authenticateButtonIsDisabled)
    }
  }
  
  func test_biometricsEnabled() {
    Scenario("Launching the app with biometrics disabled, enabling it and performing a successful authentication") {
      Given(I: acceptFaceIDAuthenticationPromptIfRequired)
      And(I: see(exampleScreen))
      And(I: seeBiometricsUnavailableStatus)
      And(the: authenticateButtonIsDisabled)
      When(the: deviceBiometricsAreEnabled)
      And(I: relaunchTheApp)
      And(I: tap(exampleScreen.authenticateButton))
      Then(I: successfullyAuthenticateBiometrics)
    }
  }
}

private extension BiometricFeature {
  
  func seeBiometricsUnavailableStatus() {
//    XCTAssertEqual(exampleScreen.authenticateLabel.label, "Biometrics unavailable")
  }
  
  func authenticateButtonIsDisabled() {
//    XCTAssertFalse(exampleScreen.authenticateButton.isEnabled)
  }
  
  func authenticateButtonIsEnabled() {
//    XCTAssertTrue(exampleScreen.authenticateButton.isEnabled)
  }
  
  func seeBiometricsAvailableStatus() {
//    XCTAssertEqual(exampleScreen.authenticateLabel.label, "Biometrics available")
  }
  
}
