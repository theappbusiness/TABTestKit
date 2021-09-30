//
//  TableTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import TABTestKit

final class TableTests: TABTestCase, SystemPreferencesContext, TabBarContext {
    
    override func preLaunchSetup(_ launch: @escaping () -> Void) {
        resetAllPrivacyPrompts()
        launch()
    }
    
    func test_table() {
        Scenario("Logging in with biometrics and landing on table screen") {
            Given(I: see(biometricLoginScreen))
            When(I: complete(biometricLoginScreen))
            Then(I: see(tableScreen))
            And(the: numberOfTabs(in: tabBarScreen.tabBar, is: 4))
        }
        
        Scenario("Refreshing the table screen") {
            Given(I: see(tableScreen))
            When(I: refresh(tableScreen))
            Then(the: state(of: tableScreen.section0Header, is: .visible))
        }
        
        Scenario("Tapping on a cell in the first section and seeing the detail screen") {
            And(I: see(tableScreen.section0Header))
            When(I: tap(tableScreen.table.cell(index: 0)))
            Then(I: see(tableSelectionScreen))
            And(the: value(of: tableSelectionScreen.navBar.header, is: "Row 0 section 0"))
        }
        
        Scenario("Scrolling to more elements") {
            Given(I: tap(tableSelectionScreen.backButton))
            And(I: scroll(tableScreen, .downwards, until: tableScreen.section1Header, is: .visible))
            And(I: scroll(tableScreen, .downwards, until: tableScreen.lastCell, is: .visible))
            When(I: tap(tableScreen.lastCell))
            Then(I: see(tableSelectionScreen))
            And(the: label(of: tableSelectionScreen.navBar.header, is: "Row 14 section 1"))
            And(the: value(of: tableSelectionScreen.navBar.header, is: "Row 14 section 1"))
        }
    }
    
}
