//
//  XCTestCase+Screenshot.swift
//  TABTestKit
//
//  Created by Stefan Renne on 09/11/2020.
//

import XCTest

extension XCTestCase {

    func attachScreenshot() {
        // if tests have no host app there is no point in making screenshots
        guard #available(iOS 9.0, OSX 10.11, *), Bundle.main.bundlePath.hasSuffix(".app") else { return }

        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot, quality: App.shared.screenshotQuality)
        attachment.lifetime = App.shared.screenshotLifetime
        add(attachment)
    }
}
