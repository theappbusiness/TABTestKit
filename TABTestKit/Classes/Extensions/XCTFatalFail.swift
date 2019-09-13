//
//  XCTFatalFail.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 12/09/2019.
//

import XCTest

/// The same as XCTFail, except it returns Never so you can use it in `guards` without specifying the `return`:
/// `guard let something = something as? Something else { XCTFatalFail("This is a failure") }`
///
/// - Parameter message: The message of the failure.
public func XCTFatalFail(_ message: String) -> Never {
	XCTFail(message)
	fatalError(message)
}
