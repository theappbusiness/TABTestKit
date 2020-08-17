//
//  BiometricLogin_PermissionDeniedTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import TABTestKit

final class BiometricLogin_PermissionDeniedTests: TABTestCase, SystemPreferencesContext {
    
    override func preLaunchSetup(_ launch: @escaping () -> Void) {
        resetAllPrivacyPrompts()
        launch()
    }
    
    func test_permissionDenied() { // TODO: This test will fail on Touch ID devices
        Scenario("Seeing the Face ID permissions prompt") {
            Given(I: see(biometricLoginScreen))
            And(deviceBiometricsAreEnabled)
            When(I: tap(biometricLoginScreen.logInButton))
            Then(I: see(biometricLoginScreen.faceIDPermissionAlert))
        }
        
        Scenario("Denying permission and seeing an error alert") {
            Given(I: see(biometricLoginScreen.faceIDPermissionAlert))
            When(I: dismiss(biometricLoginScreen.faceIDPermissionAlert))
            Then(I: see(biometricLoginScreen.biometricsUnavailableAlert))
        }
        
        Scenario("Confirming the error alert") {
            Given(I: see(biometricLoginScreen.biometricsUnavailableAlert))
            When(I: dismiss(biometricLoginScreen.biometricsUnavailableAlert))
            Then(I: doNotSee(biometricLoginScreen.biometricsUnavailableAlert))
            And(I: see(biometricLoginScreen))
            And(I: doNotSee(tableScreen))
        }
    }
    
}
