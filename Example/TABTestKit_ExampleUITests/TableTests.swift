//
//  TableTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import TABTestKit

final class TableTests: TABTestCase {
  
  func test_table() {
    Scenario("Viewing both sections") {
      Given(I: complete(biometricLoginScreen))
      Then(I: see(tableScreen))
      And(I: scroll(tableScreen, .down, until: tableScreen.table.header(forSection: 1), is: .visible))
      And(I: see("Section numero 0", in: tableScreen.table.header(forSection: 1)))
    }
  }
  
}
