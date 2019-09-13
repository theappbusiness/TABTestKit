//
//  TableTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import TABTestKit

final class TableTests: TABTestCase, SystemPreferencesContext {
  
  override func preLaunchSetup(_ launch: @escaping () -> Void) {
    resetAllPrivacyPrompts()
    launch()
  }
  
  func test_table() {
    Scenario("Tapping on a cell in the first section and seeing the detail screen") {
      Given(I: complete(biometricLoginScreen))
      When(I: see(tableScreen))
      And(I: see(tableScreen.section0Header))
      When(I: tap(tableScreen.table.cell(index: 0)))
      Then(I: see(tableSelectionScreen))
      And(the: value(of: tableSelectionScreen.navBar.header, is: "Row 0 section 0"))
    }
    
    Scenario("Scrolling to more elements") {
      Given(I: tap(tableSelectionScreen.backButton))
      And(I: scroll(tableScreen, .downwards, until: tableScreen.section1Header, .visible))
      And(I: scroll(tableScreen, .downwards, until: tableScreen.lastCell, .visible))
      When(I: tap(tableScreen.lastCell))
      Then(I: see(tableSelectionScreen))
      And(the: value(of: tableSelectionScreen.navBar.header, is: "Row 14 section 1"))
    }
  }
  
}
