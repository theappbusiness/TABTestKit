//
//  CollectionViewTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/10/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import TABTestKit

final class CollectionViewTests: TABTestCase, SystemPreferencesContext {
  
  override func preLaunchSetup(_ launch: @escaping () -> Void) {
    resetAllPrivacyPrompts()
    launch()
  }
  
  func test_collectionView() {
    Scenario("Completing biometric login and tapping the collection tab bar button") {
      Given(I: complete(biometricLoginScreen))
      When(I: tap(tabBarScreen.collectionTabBarButton))
      Then(I: see(collectionViewScreen))
    }
    
    Scenario("Scrolling until the first cell is hidden") {
      Given(the: state(of: collectionViewScreen.firstCell, is: .visible))
      When(I: scroll(collectionViewScreen, .from(.topThird, to: .top), until: collectionViewScreen.lastCell, is: .exists, .visibleIn(collectionViewScreen.trait)))
      Then(the: state(of: collectionViewScreen.firstCell, isNot: .exists))
    }
  }
  
}
