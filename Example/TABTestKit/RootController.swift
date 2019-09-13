//
//  RootController.swift
//  TABTestKit_Example
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

final class RootController: UITabBarController {
  
  private var hasLoggedIn = false
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if !hasLoggedIn {
      performSegue(withIdentifier: "BiometricLoginViewController", sender: nil)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.destination {
    case let controller as BiometricLoginViewController:
      controller.delegate = self
    default: assertionFailure("Unhandled segue")
    }
  }
  
}

extension RootController: BiometricLoginViewControllerDelegate {
  
  func biometricLoginViewControllerDidLogIn(_ controller: BiometricLoginViewController) {
    hasLoggedIn = true
    controller.dismiss(animated: true)
  }
  
}
