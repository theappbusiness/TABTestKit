//
//  PageTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Ben Gilroy on 10/07/2020.
//  Copyright © 2020 The App Business LTD. All rights reserved.
//

import TABTestKit

final class PageTests: TABTestCase {

    func test() {
        Scenario("Navigate to page view") {
            Given(I: complete(biometricLoginScreen))
            And(I: see(tabBarScreen))
            When(I: tap(tabBarScreen.pageTabBarButton))
            sleep(1)
            print(App.shared.debugDescription)
            Then(I: see(pageScreen))
        }
        
        // TODO: Replace with 'scroll until value of X is Y' as part of https://github.com/theappbusiness/TABTestKit/issues/72
        Scenario("Scroll page view") {
            Given(I: see(pageScreen))
            When(I: pageScreen.scrollView.scroll(.right))
            And(I: pageScreen.scrollView.scroll(.right))
            And(I: pageScreen.scrollView.scroll(.right))
            And(I: pageScreen.scrollView.scroll(.right))
            And(I: pageScreen.scrollView.scroll(.right))
            Then(the: value(of: pageScreen.pageIndicator, is: "page 6 of 6"))
        }
    }

}
