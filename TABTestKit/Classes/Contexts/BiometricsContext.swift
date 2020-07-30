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
	
	func deviceBiometricsAreEnabled() {
		Biometrics.enrolled()
	}
	
	func deviceBiometricsAreDisabled() {
		Biometrics.unenrolled()
	}
	
	func successfullyAuthenticateBiometrics() {
		Biometrics.successfulAuthentication()
	}
	
	func failToAuthenticateBiometrics() {
		Biometrics.unsuccessfulAuthentication()
	}
	
}
