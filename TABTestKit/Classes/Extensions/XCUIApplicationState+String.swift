//
//  XCUIApplicationState+String.swift
//  TABTestKit
//
//  Created by Stefan Renne on 06/11/2020.
//

import XCTest

extension XCUIApplication.State: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown:
            return "unknown"
        case .notRunning:
            return "not running"
        case .runningBackgroundSuspended:
            return "running background suspended"
        case .runningBackground:
            return "running background"
        case .runningForeground:
            return "running foreground"
        @unknown default:
            return "unknown"
        }
    }
}
