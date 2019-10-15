//
//  NormalizedCoordinate+Locations.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 14/10/2019.
//

import XCTest

public extension CGVector {
	
	/// The middle of the element:
	///  _________
	/// |         |
	/// |         |
	/// |    *    |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let middle = CGVector(dx: 0.5, dy: 0.5)
	
	/// The top of the element:
	///  _________
	/// |    *    |
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let top = CGVector(dx: 0.5, dy: 0)
	
	/// The bottom of the element:
	///  _________
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	/// |    *    |
	///  ‾‾‾‾‾‾‾‾‾
	static let bottom = CGVector(dx: 0.5, dy: 1)
	
	/// The left of the element:
	///  _________
	/// |         |
	/// |         |
	/// |*        |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let left = CGVector(dx: 0, dy: 0.5)
	
	/// The right of the element:
	///  _________
	/// |         |
	/// |         |
	/// |        *|
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let right = CGVector(dx: 1, dy: 0.5)
	
	/// The top left of the element:
	///  _________
	/// |*        |
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let topLeft = CGVector(dx: 0, dy: 0)
	
	/// The top right of the element:
	///  _________
	/// |        *|
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let topRight = CGVector(dx: 1, dy: 0)
	
	/// The bottom left of the element:
	///  _________
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	/// |*        |
	///  ‾‾‾‾‾‾‾‾‾
	static let bottomLeft = CGVector(dx: 0, dy: 1)
	
	/// The bottom right of the element:
	///  _________
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	/// |        *|
	///  ‾‾‾‾‾‾‾‾‾
	static let bottomRight = CGVector(dx: 1, dy: 1)
	
	/// The top third of the element:
	///  _________
	/// |         |
	/// |    *    |
	/// |         |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let topThird = CGVector(dx: 0.5, dy: 0.33)
	
	/// The left third of the element:
	///  _________
	/// |         |
	/// |         |
	/// |  *      |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let leftThird = CGVector(dx: 0.33, dy: 0.5)
	
	/// The bottom third of the element:
	///  _________
	/// |         |
	/// |         |
	/// |         |
	/// |    *    |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let bottomThird = CGVector(dx: 0.5, dy: 0.66)
	
	/// The right third of the element:
	///  _________
	/// |         |
	/// |         |
	/// |      *  |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let rightThird = CGVector(dx: 0.66, dy: 0.5)
	
}
