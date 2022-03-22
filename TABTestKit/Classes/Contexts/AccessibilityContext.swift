//
//  AccessibilityContext.swift
//  TABTestKit
//
//  Created by Stefan Renne on 22/03/2022.
//

import XCTest

public protocol AccessibilityContext {}
public extension AccessibilityContext {

    func setTextAccessibilitySizeToXXXL() -> StepAction {
        return StepAction(description: "set text accessibility size to XXXL") {
            App.shared.launchArguments.append("-UIPreferredContentSizeCategoryName")
            App.shared.launchArguments.append("UICTContentSizeCategoryAccessibilityXXXL")
        }
    }
}
