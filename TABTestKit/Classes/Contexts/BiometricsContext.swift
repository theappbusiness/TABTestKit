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

public protocol BiometricsContext {}
public extension BiometricsContext {
	
	func deviceBiometricsAreEnabled() -> StepAction {
        StepAction {
            Biometrics.enrolled()
        }
	}
	
	func deviceBiometricsAreDisabled() -> StepAction {
        StepAction {
            Biometrics.unenrolled()
        }
	}
	
	func successfullyAuthenticateBiometrics() -> StepAction {
        StepAction {
            Biometrics.successfulAuthentication()
        }
	}
	
	func failToAuthenticateBiometrics() -> StepAction {
        StepAction {
            Biometrics.unsuccessfulAuthentication()
        }
	}
	
}
