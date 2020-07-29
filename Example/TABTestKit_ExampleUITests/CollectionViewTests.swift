//
//  CollectionViewTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/10/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
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
      And(the: label(of: collectionViewScreen.header, is: "Collection"))
    }
    
    Scenario("Scrolling until the first cell is hidden") {
      Given(the: state(of: collectionViewScreen.firstCell, is: .visible))
      When(I: scroll(collectionViewScreen, .from(.middle, to: .top), until: collectionViewScreen.lastCell, is: .exists, .visibleIn(collectionViewScreen.trait)))
      Then(the: state(of: collectionViewScreen.firstCell, isNot: .exists))
    }
    
    Scenario("Scrolling until the last cell is hidden") {
      Given(the: state(of: collectionViewScreen.lastCell, is: .visible))
      When(I: scroll(collectionViewScreen, .from(.middle, to: .bottom), until: collectionViewScreen.lastCell, isNot: .exists))
      Then(the: state(of: collectionViewScreen.firstCell, isNot: .exists))
      And(the: state(of: collectionViewScreen.lastCell, isNot: .exists))
    }
  }
  
}
