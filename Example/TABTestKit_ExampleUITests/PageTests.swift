//
//  PageTests.swift
//  TABTestKit_ExampleUITests
//
//  Created by Ben Gilroy on 10/07/2020.
//  Copyright © 2020 Kin + Carta. All rights reserved.
//

import TABTestKit

final class PageTests: TABTestCase {

    func test() {
        // This test will fail on iOS 12 as the scroll view in UIPageViewController
        // does not have the accessibility trait of scroll view. This has been fixed
        // in iOS 13. When iOS 12 support is dropped, this check can be removed.
        guard #available(iOS 13, *) else {
            return
        }
        
        Scenario("Navigate to page view") {
            Given(I: complete(biometricLoginScreen))
            And(I: see(tabBarScreen))
            When(I: tap(tabBarScreen.pageTabBarButton))
            Then(I: see(pageScreen))
        }
        
        Scenario("Scroll page view") {
            Given(I: see(pageScreen))
            When(I: scroll(pageScreen.scrollView, .right, until: pageScreen.pageIndicator, valueIs: "page 6 of 6"))
            Then(the: value(of: pageScreen.pageIndicator, is: "page 6 of 6"))
        }
    }

}
