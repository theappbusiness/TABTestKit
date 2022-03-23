//
//  BiometricsContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation
#if canImport(Biometrics)
import Biometrics
#endif

public extension TABTestCase {
	
	func deviceBiometricsAreEnabled() -> StepAction {
        return StepAction(description: "device biometrics are enabled") {
            Biometrics.enrolled()
        }
	}
	
	func deviceBiometricsAreDisabled() -> StepAction {
        return StepAction(description: "device biometrics are disabled") {
            Biometrics.unenrolled()
        }
	}
	
	func successfullyAuthenticateBiometrics() -> StepAction {
        return StepAction(description: "successfully authenticate biometrics") {
            Biometrics.successfulAuthentication()
        }
	}
	
	func failToAuthenticateBiometrics() -> StepAction {
        return StepAction(description: "fail to authenticate biometrics") {
            Biometrics.unsuccessfulAuthentication()
        }
	}
}
