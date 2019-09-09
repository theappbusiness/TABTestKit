//
//  BaseTestCase.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 The App Business LTD. All rights reserved.
//

import XCTest

/// All tests should inherit from this class.
/// By inheriting from this class, you'll automatically get all the functions available in the contexts this class
/// conforms to.
open class TABTestCase: XCTestCase, InteractionContext, NavigationContext, AppContext, BiometricsContext, AlertContext {
	
	/// Provides the setup for appication that happens before each XCTestCase.
	/// As part of setUp, preLaunchSetup will be called.
	/// Override preLaunchSetup to provide custom prelaunch setup behaviour.
	open override func setUp() {
		continueAfterFailure = false
		Biometrics.unenrolled()
		App().launchEnvironment["TABTestKit.UUID"] = ProcessInfo.processInfo.environment["SIMULATOR_UDID"]
		preLaunchSetup {
			App().launch(clean: true)
		}
	}
	
	/// Provides the tear down for the application and each XCTestCase.
	/// As part of tearDown, preTerminationTearDown will be called.
	/// Override preTerminationTearDown to provide custom pretermination tear down behaviour.
	open override func tearDown() {
		preTerminationTearDown {
			App().terminate()
		}
	}
	
	/// Called automatically as part of setUp to allow you to provide your own prelaunch setup.
	/// For example you could use this to reset a mock server's state or collected analytics.
	/// By default this function does nothing except call the completion handler, so calling the super implementation
	/// is not required, so long as you call the completion handler in your own implementation.
	///
	/// - Parameter completion: The completion to call when your prelaunch setup is complete.
	open func preLaunchSetup(_ completion: @escaping () -> Void) {
		completion()
	}
	
	/// Called automatically as part of tearDown to allow you to provide your own preTermination tear down.
	/// For example you could use this to unregister
	/// By default this function does nothing except call the completion handler, so calling the super implementation
	/// is not required, so long as you call the completion handler in your own implementation.
	///
	/// - Parameter completion: The completion to call when your prelaunch setup is complete.
	open func preTerminationTearDown(_ completion: @escaping () -> Void) {
		completion()
	}
	
	override open func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: Int, expected: Bool) {
		// When using Steps and Scenarios it can be really hard to pinpoint where failed, so this attachment saves the info with the last known step and scenario (including the line that failed), to help you.
		// You can find this attachment in the .xcresult bundle (usually Derived Data).
		let attachment = createFailureAttachment(description: description, filePath: filePath, lineNumber: lineNumber)
		add(attachment)
		super.recordFailure(withDescription: description, inFile: filePath, atLine: lineNumber, expected: expected)
	}
	
	private func createFailureAttachment(description: String, filePath: String, lineNumber: Int) -> XCTAttachment {
		let attachmentInfo = """
		Full failure info (scenarios and steps may be in a different file to the actual failure):
		
		Failed scenario: \(Scenario.current?.description ?? "No scenario")
		Failed step: \(name) on line \(Step.current?.line ?? 0)
		
		Actual file that failed: \(filePath)
		Actual line that failed: \(lineNumber)
		
		Description: \(description)
		"""
		let attachment = XCTAttachment(string: attachmentInfo)
		attachment.name = "Failure at \(Date())"
		return attachment
	}
	
}
