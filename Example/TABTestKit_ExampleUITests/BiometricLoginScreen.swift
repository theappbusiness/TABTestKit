//
//  BiometricLoginScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import TABTestKit

let biometricLoginScreen = BiometricLoginScreen()

struct BiometricLoginScreen: Screen {
  
  let trait = Header(id: "Welcome")
  let logInLabel = Label(id: "Please log in with biometrics")
  let logInButton = Button(id: "Log in")
  let faceIDPermissionAlert = Alert(id: "Do you want to allow “TABTestKit_Example” to use Face ID?", parent: Springboard(), confirmButtonID: "OK", dismissButtonID: "Don’t Allow") // The style of apostrophe is actually important in "Don’t Allow", rather than "Don't Allow" which will fail!
  let faceNotRecognizedAlert = Alert(id: "", parent: Springboard(), confirmButtonID: "Try Face ID Again", dismissButtonID: "Cancel")
  let biometricsUnavailableAlert = Alert(id: "Login failed", confirmButtonID: "OK")
  let biometricsFailedAlert = Alert(id: "Login failed", confirmButtonID: "OK")
  
}

extension BiometricLoginScreen: Completable {
  
  func complete() {
    logInButton.tap()
    faceIDPermissionAlert.confirmButton.tap()
    Biometrics.successfulAuthentication()
  }
  
}
