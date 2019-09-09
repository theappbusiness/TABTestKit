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

/// All tests should inherit from this class
open class BaseTestCase: XCTestCase {
	
	/// Provides the setup for appication that happens before each XCTestCase
	/// As part of setUp, prelaunchSetup will be called.
	/// Override prelaunchSetup to provide custom prelaunch setup behaviour.
	open override func setUp() {
		continueAfterFailure = false
		Biometrics.unenrolled()
		prelaunchSetup {
			App.shared.launch()
		}
	}
	
	/// Called automatically as part of setUp to allow you to provide your own prelaunch setup.
	/// For example you could use this to reset a mock server's state or collected analytics.
	/// By default this function does nothing except call the completion handler, so calling the super implementation
	/// is not required, so long as you call the completion handler in your own implementation.
	///
	/// - Parameter completion: The completion to call when your prelaunch setup is complete.
	open func prelaunchSetup(_ completion: @escaping () -> Void) { // TODO: Test
		completion()
	}
	
	/// Provides the tear down for the application and each XCTestCase
	open override func tearDown() {
		App.shared.terminate()
	}
}
