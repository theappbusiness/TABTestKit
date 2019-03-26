//
//  ViewController.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 09/14/2017.
//  Copyright (c) 2017 Zachary Borrelli. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
  @IBOutlet private var helloWorldLabel: UILabel!
  @IBOutlet private var testTextField: UITextField!
  @IBOutlet private var biometricsStateLabel: UILabel!
  @IBOutlet private var authenticateButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    setup()
  }
  
  private func configure() {
    helloWorldLabel.text = "Hello world!"
    testTextField.accessibilityIdentifier = "Test Text Field"
    helloWorldLabel.accessibilityIdentifier = "Hello World Label"
  }
  
  @objc private func setup() {
    let context = LAContext()
    var error: NSError?
    let errorPointer: NSErrorPointer = NSErrorPointer(&error)
    let isBiometryAvailable = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: errorPointer)
    if isBiometryAvailable {
      handleBiometryAvailable()
    } else {
      handleBiometryUnavailable()
    }
  }
  
  private func handleBiometryAvailable() {
    biometricsStateLabel.text = "Biometrics available"
    authenticateButton.isEnabled = true
  }
  
  private func handleBiometryUnavailable() {
    biometricsStateLabel.text = "Biometrics unavailable"
    authenticateButton.isEnabled = false
  }
  
  @IBAction private func authenticateButtonTapped(_ sender: UIButton) {
    let context = LAContext()
    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate now!", reply: { _, _ in })
  }
}

