//
//  AccessibilityContext.swift
//  TABTestKit
//
//  Created by Stefan Renne on 22/03/2022.
//

import XCTest

public extension TABTestCase {

    func setTextAccessibilitySizeToXXXL() -> StepAction {
        return StepAction(description: "set text accessibility size to XXXL") {
            App.shared.launchArguments.append("-UIPreferredContentSizeCategoryName")
            App.shared.launchArguments.append("UICTContentSizeCategoryAccessibilityXXXL")
        }
    }
}
