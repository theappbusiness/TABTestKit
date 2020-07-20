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
