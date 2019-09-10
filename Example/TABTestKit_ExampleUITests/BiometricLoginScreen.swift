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
  
}

extension BiometricLoginScreen: Completable {
  
  func complete() {
    logInButton.tap()
    let permissionsAlert = FaceIDPermissionAlert()
    if permissionsAlert.determine(.exists, timeout: 1) {
      permissionsAlert.okButton.tap()
    }
    Biometrics.successfulAuthentication()
  }
  
}
