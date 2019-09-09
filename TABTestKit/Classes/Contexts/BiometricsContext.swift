//
//  BiometricsContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

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
	
	func acceptFaceIDAuthenticationPromptIfRequired() {
		let okayButton = Springboard().alerts.buttons["OK"].firstMatch
		if okayButton.exists { // TouchID does not have a permissions prompt
			okayButton.tap()
		}
	}
	
}
