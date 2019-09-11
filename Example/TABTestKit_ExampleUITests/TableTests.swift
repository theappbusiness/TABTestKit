//
//  TableTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import TABTestKit

final class TableTests: TABTestCase, SystemPreferencesContext {
  
  override func preLaunchSetup(_ completion: @escaping () -> Void) {
    resetAllPrivacyPrompts()
    completion()
  }
  
  func test_table() {
    Scenario("Viewing both sections") {
      Given(I: complete(biometricLoginScreen))
      Then(I: see(tableScreen))
      And(I: see(tableScreen.table.header(withID: "SECTION NUMERO 0")))
      And(I: scroll(tableScreen, .down, until: tableScreen.table.header(withID: "SECTION NUMERO 1"), .exists))
    }
  }
  
}
