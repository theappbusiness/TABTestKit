//
//  BiometricLoginScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import TABTestKit

let biometricLoginScreen = BiometricLoginScreen()

struct BiometricLoginScreen: Screen {
    
    let trait = Header(id: "Welcome")
    let logInLabel = Label(id: "Please log in with biometrics")
    let logInButton = Button(id: "Log in")
    let faceIDPermissionAlert: Alert = .faceIDPermission
    let faceNotRecognizedAlert: Alert = .faceNotRecognized
    let biometricsUnavailableAlert: Alert = .biometricsUnavailable
    let biometricsFailedAlert: Alert = .biometricsFailed
    
}

extension BiometricLoginScreen: Completable {
    
    func complete() {
        Biometrics.enrolled()
        logInButton.tap()
        if faceIDPermissionAlert.determine(.exists, timeout: 1) {
            faceIDPermissionAlert.actionButton(withID: "OK").tap()
        }
        Biometrics.successfulAuthentication()
    }
    
}

extension Alert {
    
    // The style of apostrophe is actually important in "Don’t Allow", rather than "Don't Allow" which will fail!
    static let faceIDPermission = Alert(id: "Do you want to allow “TABTestKit_Example” to use Face ID?", parent: springboard, dismissButtonID: "Don’t Allow")
    static let faceNotRecognized = Alert(id: nil, parent: springboard, dismissButtonID: "Cancel")
    static let biometricsUnavailable = Alert(id: "Login failed", dismissButtonID: "OK") // TODO: Assert message? Since both have the same title
    static let biometricsFailed = Alert(id: "Login failed", dismissButtonID: "OK")
    
}
