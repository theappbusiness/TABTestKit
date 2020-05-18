//
//  DeepLinkingTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 18/05/2020.
//  Copyright © 2020 The App Business LTD. All rights reserved.
//

import TABTestKit

final class DeepLinkingTests: TABTestCase {

  func test() {
    Scenario("Deep linking from current state") {
      Given(I: complete(biometricLoginScreen))
      When(I: tap(tabBarScreen.otherTabBarButton))
      And(I: open(.deepLinkURL))
      And(I: tap("Open", in: openAppConfirmationAlert)) // You will need to erase the simulator if you've already accepted this alert once
      Then(I: see(otherElementsScreen))
    }
    Scenario("Deep linking from terminated state") {
      Given(I: see(otherElementsScreen))
      When(I: terminateTheApp)
      And(I: open(.deepLinkURL))
      And(I: waitForApp(toBe: .runningForeground))
      Then(I: doNotSee(otherElementsScreen))
      And(I: see(biometricLoginScreen))
    }
  }

}


extension URL {

  static let deepLinkURL = URL(string: "my-amazing-app://deep-link")!

}

let openAppConfirmationAlert = Alert(id: "“TABTestKit_ExampleUITests-Runner” wants to open “TABTestKit_Example”", parent: springboard)
