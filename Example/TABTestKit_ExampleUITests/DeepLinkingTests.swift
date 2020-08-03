//
//  DeepLinkingTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 18/05/2020.
//  Copyright © 2020 Kin + Carta. All rights reserved.
//

import TABTestKit

final class DeepLinkingTests: TABTestCase {
    
    func test() {
        Scenario("Deep linking from current state") {
            Given(I: complete(biometricLoginScreen))
            When(I: tap(tabBarScreen.otherTabBarButton))
            And(I: open(.deepLinkURL))
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
