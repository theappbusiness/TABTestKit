//
//  ExampleFeature.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import TABTestKit

class ExampleFeature: TestBase {
  
  private let exampleScreen = ExampleScreen()
  
  func test_example() {
    Scenario("Backgrounding and foregrounding the app") {
      Given(I: backgroundTheApp)
      When(I: foregroundTheApp)
      Then(I: seeTheExampleScreen)
    }
  }
}

class BiometricTests: XCTestCase {
  
  private var app: XCUIApplication!
  
  private lazy var authenticateButton = app.buttons.element(matching: .button, identifier: "authenticateButton")
  private lazy var authenticateLabel = app.staticTexts.element(matching: .any, identifier: "biometricStatusLabel")
  
  override func setUp() {
    app = XCUIApplication()
  }

  override func tearDown() {
    app = nil
  }
  
  func test_launchWithBiometricsDisabled() {
    performUnenrollment()
    app.launch()
    Scenario("Launching the app with biometrics disabled") {
      Given(I: seeBiometricsUnavailableStatus())
      Given(I: seeAuthenticateButtonIsDisabled())
    }
  }
  
  func test_biometricsEnabled() {
    performEnrollment()
    app.launch()
    Scenario("Enroll biometrics, background & foreground the app and then perform successful authentication") {
      Given(I: seeBiometricsAvailableStatus)
      Given(I: seeAuthenticateButtonIsEnabled)
      When(I: tapAuthenticateButton)
      Then(I: performSuccessfulAuthentication)
    }
  }
}

private extension ExampleFeature {
  
  func backgroundTheApp() {
    XCUIDevice.shared.press(.home)
  }
  
  func foregroundTheApp() {
    App.shared.activate()
  }
  
  func seeTheExampleScreen() {
    exampleScreen.await()
  }

}

private extension BiometricTests {
  
  func performEnrollment() {
    Biometrics.enrolled()
  }
  
  func performUnenrollment() {
    Biometrics.unenrolled()
  }
  
  func tapAuthenticateButton() {
    authenticateButton.tap()
  }
  
  func performSuccessfulAuthentication() {
    Biometrics.successfulAuthentication()
  }
  
  func seeBiometricsUnavailableStatus() {
    XCTAssertEqual(authenticateLabel.label, "Biometrics unavailable")
  }
  
  func seeAuthenticateButtonIsDisabled() {
    XCTAssertFalse(authenticateButton.isEnabled)
  }
  
  func seeAuthenticateButtonIsEnabled() {
    XCTAssertTrue(authenticateButton.isEnabled)
  }
  
  func seeBiometricsAvailableStatus() {
    XCTAssertEqual(authenticateLabel.label, "Biometrics available")
  }
}
