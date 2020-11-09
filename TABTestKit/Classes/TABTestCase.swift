//
//  TABTestCase.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 Kin + Carta. All rights reserved.
//

import XCTest
#if canImport(Biometrics)
import Biometrics
#endif

/// The default contexts that TABTestCase conforms to, to provide lots of helpful functions to make it highly possible
/// you don't have to write any extra test functions for your tests.
public typealias DefaultContexts = InteractionContext & NavigationContext & AppContext & BiometricsContext & AlertContext & SheetContext & KeyboardContext

/// All tests should inherit from this class.
/// By inheriting from this class, you'll automatically get all the functions available in the contexts this class
/// conforms to.
///
/// Aditionally, you get some common setup behaviour for free, like unenrolling Biometrics ready for the next test,
/// and a UUID set for the launchEnvironment which you can use to uniquely identify
/// a simulator in parallel tests, which is useful for mock servers.
///
/// TABTestCase will automatically launch and terminate your app as part of setUp and tearDown. You can
/// delay launch and termination to perform some additional work, by overriding preLaunchSetup and preTerminationTearDown.
///
/// Finally, TABTestCase will help you by creating attachments when tests failed, with the last known Scenario and Step
/// which are found in the xcresult bundle created as part of the test run (usually in Derived Data).
open class TABTestCase: XCTestCase, DefaultContexts {

    public struct ScreenshotOption: OptionSet {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let onFailure = ScreenshotOption(rawValue: 1 << 0)
        public static let beforeStep = ScreenshotOption(rawValue: 1 << 1)
        public static let afterStep = ScreenshotOption(rawValue: 1 << 2)
        public static let none: ScreenshotOption = []
        public static let all: ScreenshotOption = [.onFailure, .beforeStep, .afterStep]
    }

    /// A reference to the most recently created TABTestCase.
    public static var current: TABTestCase?

    public private(set) var screenshotOption: ScreenshotOption = .none
    public private(set) var screenshotQuality: XCTAttachment.ImageQuality = .medium
    public private(set) var screenshotLifetime: XCTAttachment.Lifetime = .deleteOnSuccess

    open override func invokeTest() {
        TABTestCase.current = self
        super.invokeTest()
    }
	
	/// Provides the setup for application that happens before each XCTestCase.
	/// As part of setUp, preLaunchSetup will be called.
	/// Override preLaunchSetup to provide custom prelaunch setup behaviour.
	open override func setUp() {
		continueAfterFailure = false
		Biometrics.unenrolled()
		App.shared.launchEnvironment["TABTestKit.UUID"] = ProcessInfo.processInfo.environment["SIMULATOR_UDID"]
		preLaunchSetup {
			App.shared.launch(clean: true)
		}
	}
	
	/// Provides the tear down for the application and each XCTestCase.
	/// As part of tearDown, preTerminationTearDown will be called after
	/// clearing the `App.shared` `launchEnvironment` and `launchArguments`.
	/// Override preTerminationTearDown to provide custom pretermination tear down behaviour.
	open override func tearDown() {
		App.shared.launchEnvironment.removeAll()
		App.shared.launchArguments.removeAll()
		preTerminationTearDown {
			App.shared.terminate()
		}
	}
	
	/// Called automatically as part of setUp to allow you to provide your own prelaunch setup.
	/// For example you could use this to reset a mock server's state or collected analytics.
	/// By default this function does nothing except call the launch handler, so calling the super implementation
	/// is not required, so long as you call the launch handler in your own implementation.
	///
	/// - Parameter launch: The handler to call when your prelaunch setup is complete to launch the app.
	open func preLaunchSetup(_ launch: @escaping () -> Void) {
		launch()
	}
	
	/// Called automatically as part of tearDown to allow you to provide your own preTermination tear down.
	/// For example you could use this to unregister a custom UUID on a mock server.
	/// By default this function does nothing except call the terminate handler, so calling the super implementation
	/// is not required, so long as you call the terminate handler in your own implementation.
	///
	/// - Parameter terminate: The handler to call when your prelaunch setup is complete.
	open func preTerminationTearDown(_ terminate: @escaping () -> Void) {
		terminate()
	}

    /// Changes the screenshot behavior
    public func setScreenshots(option: ScreenshotOption, quality: XCTAttachment.ImageQuality = .medium, lifetime: XCTAttachment.Lifetime = .deleteOnSuccess) {
        screenshotOption = option
        screenshotQuality = quality
        screenshotLifetime = lifetime
    }

    public func createScreenshotIfNeeded(for option: ScreenshotOption ) {
        guard screenshotOption.contains(option) else { return }

        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot, quality: screenshotQuality)
        attachment.lifetime = screenshotLifetime
        add(attachment)
    }
	
	override open func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: Int, expected: Bool) {
		// When using Steps and Scenarios it can be really hard to pinpoint where failed, so this attachment saves the info with the last known step and scenario (including the line that failed), to help you.
		// You can find this attachment in the .xcresult bundle (usually Derived Data).
		let attachment = createFailureAttachment(description: description, filePath: filePath, lineNumber: lineNumber)
		add(attachment)

        createScreenshotIfNeeded(for: .onFailure)
        
		let filePath = Step.current?.filePath ?? filePath
		let lineNumber = Step.current?.lineNumber ?? lineNumber
		super.recordFailure(withDescription: description, inFile: filePath, atLine: lineNumber, expected: expected)
	}
	
	private func createFailureAttachment(description: String, filePath: String, lineNumber: Int) -> XCTAttachment {
		let attachmentInfo = """
		Full failure info (scenarios and steps may be in a different file to the actual failure):
		
		Failed scenario: \(Scenario.current?.description ?? "No scenario")
		Failed step: \(name) on line \(Step.current?.line ?? 0) in file \(Step.current?.file ?? "unknown")
		
		Actual file that failed: \(filePath)
		Actual line that failed: \(lineNumber)
		
		Description: \(description)
		"""
		let attachment = XCTAttachment(string: attachmentInfo)
		attachment.name = "Failure at \(Date())"
		return attachment
	}
	
}

private extension Step {
	var filePath: String {
		return "\(file)"
	}
	var lineNumber: Int {
		return Int(line)
	}
}
