//
//  BiometricLoginViewController.swift
//  TABTestKit_Example
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import LocalAuthentication

protocol BiometricLoginViewControllerDelegate: AnyObject {
  
  func biometricLoginViewControllerDidLogIn(_ controller: BiometricLoginViewController)
  
}

final class BiometricLoginViewController: UIViewController {
  
  @IBOutlet private var welcomeHeaderLabel: UILabel!
  @IBOutlet private var pleaseLogInLabel: UILabel!
  @IBOutlet private var logInButton: UIButton!
  
  @IBAction private func logInTapped() {
    let context = LAContext()
    let canUseBiometrics = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .init(nilLiteral: ()))
    if canUseBiometrics {
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Log in", reply: { [weak self] wasSuccessful, error in
        DispatchQueue.main.async {
          if wasSuccessful {
            self?.handleSuccessfulLogin()
          } else {
            self?.handleBiometricsFailed()
          }
        }
      })
    } else {
      handleBiometricsDisabled()
    }
  }
  
  weak var delegate: BiometricLoginViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    welcomeHeaderLabel.accessibilityTraits = .header
  }
  
  private func handleSuccessfulLogin() {
    delegate?.biometricLoginViewControllerDidLogIn(self)
  }
  
  private func handleBiometricsDisabled() {
    showOKAlert(title: "Login failed", message: "Biometrics are unavailable on this device")
  }
  
  private func handleBiometricsFailed() {
    showOKAlert(title: "Login failed", message: "Failed to authenticate")
  }
  
  private func showOKAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(.init(title: "OK", style: .cancel))
    present(alert, animated: true)
  }
  
}
