//
//  App.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 Kin + Carta. All rights reserved.
//

import XCTest

/// Represents the app being tested.
/// Using this instead of XCUIApplication() means you get the
/// enhanced waits for the correct states when launching/backgrounding etc, inherited from BaseApp.
public final class App: BaseApp {

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
	
	/// The shared App instance. Using a shared instance ensure consistency with launch arguments.
	public static let shared = App()

    public private(set) var screenshotOption: ScreenshotOption = .none
    public private(set) var screenshotQuality: XCTAttachment.ImageQuality = .medium
    public private(set) var screenshotLifetime: XCTAttachment.Lifetime = .deleteOnSuccess
	
	private override init() { super.init() }

    /// Changes the screenshot behavior
    public func setScreenshots(option: ScreenshotOption, quality: XCTAttachment.ImageQuality = .medium, lifetime: XCTAttachment.Lifetime = .deleteOnSuccess) {
        screenshotOption = option
        screenshotQuality = quality
        screenshotLifetime = lifetime
    }
	
	/// Launches the app, cleaning if required.
	/// Note you are responsible for implementing these launch arguments at the appropriate time in your launch cycle,
	/// and it is up to you to decide what "clean" means.
	public func launch(clean shouldClean: Bool) { // TODO: Disable animations option
		if shouldClean {
			launchArguments.append("TABTestKit.Clean")
		} else {
			launchArguments.removeAll { $0 == "TABTestKit.Clean" }
		}
		super.launch()
	}
}
