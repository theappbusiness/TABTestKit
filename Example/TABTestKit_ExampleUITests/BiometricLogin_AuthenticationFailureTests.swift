//
//  BiometricLogin_AuthenticationFailureTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import TABTestKit

final class BiometricLogin_AuthenticationFailureTests: TABTestCase, SystemPreferencesContext {
  
  override func preLaunchSetup(_ launch: @escaping () -> Void) {
    resetAllPrivacyPrompts()
    launch()
  }
  
  func test_authenticationFailure() {
    Scenario("Seeing the Face ID permissions prompt") {
      Given(I: see(biometricLoginScreen))
      And(deviceBiometricsAreEnabled)
      When(I: tap(biometricLoginScreen.logInButton))
      Then(I: see(biometricLoginScreen.faceIDPermissionAlert))
    }
    
    Scenario("Allowing permission but failing authentication") {
      Given(I: see(biometricLoginScreen.faceIDPermissionAlert))
      And(I: tap("OK", in: biometricLoginScreen.faceIDPermissionAlert))
      When(I: failToAuthenticateBiometrics)
      Then(I: see(biometricLoginScreen.faceNotRecognizedAlert))
    }
    
    Scenario("Cancelling Face ID") {
      Given(I: see(biometricLoginScreen.faceNotRecognizedAlert))
      When(I: dismiss(biometricLoginScreen.faceNotRecognizedAlert))
      And(I: doNotSee(biometricLoginScreen.faceNotRecognizedAlert))
      Then(I: see(biometricLoginScreen.biometricsFailedAlert))
    }
    
    Scenario("Dismissing failure alert") {
      Given(I: see(biometricLoginScreen.biometricsFailedAlert))
      When(I: dismiss(biometricLoginScreen.biometricsFailedAlert))
      Then(I: see(biometricLoginScreen))
      And(I: doNotSee(tableScreen))
    }
  }
  
}
