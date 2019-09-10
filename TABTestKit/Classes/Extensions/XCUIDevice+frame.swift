//
//  XCUIDevice+frame.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import XCTest

public extension XCUIDevice {
	
	/// Returns a frame representing the viewport of the device.
	/// This is achieved by getting Springboard's main window and returning that frame.
	/// The origin of this frame is always 0,0, the size will vary based on device.
	var frame: CGRect {
		return Springboard().windows.firstMatch.frame
	}
	
}


