//
//  StepAction.swift
//  TABTestKit
//
//  Created by Stefan Renne on 05/11/2020.
//

import Foundation

public struct StepAction {
    public let description: String
    public let execute: () -> Void
}
