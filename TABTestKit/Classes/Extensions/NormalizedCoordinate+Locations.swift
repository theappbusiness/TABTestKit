//
//  NormalizedCoordinate+Locations.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 14/10/2019.
//

import XCTest

public extension ElementAttributes.Direction.NormalizedCoordinate {
	
	/// The middle of the element:
	///  _________
	/// |         |
	/// |         |
	/// |    *    |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let middle = ElementAttributes.Direction.NormalizedCoordinate(dx: 0.5, dy: 0.5)
	
	/// The top of the element:
	///  _________
	/// |    *    |
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let top = ElementAttributes.Direction.NormalizedCoordinate(dx: 0.5, dy: 0)
	
	/// The bottom of the element:
	///  _________
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	/// |    *    |
	///  ‾‾‾‾‾‾‾‾‾
	static let bottom = ElementAttributes.Direction.NormalizedCoordinate(dx: 0.5, dy: 1)
	
	/// The left of the element:
	///  _________
	/// |         |
	/// |         |
	/// |*        |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let left = ElementAttributes.Direction.NormalizedCoordinate(dx: 0, dy: 0.5)
	
	/// The right of the element:
	///  _________
	/// |         |
	/// |         |
	/// |        *|
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let right = ElementAttributes.Direction.NormalizedCoordinate(dx: 1, dy: 0.5)
	
	/// The top left of the element:
	///  _________
	/// |*        |
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let topLeft = ElementAttributes.Direction.NormalizedCoordinate(dx: 0, dy: 0)
	
	/// The top right of the element:
	///  _________
	/// |        *|
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let topRight = ElementAttributes.Direction.NormalizedCoordinate(dx: 1, dy: 0)
	
	/// The bottom left of the element:
	///  _________
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	/// |*        |
	///  ‾‾‾‾‾‾‾‾‾
	static let bottomLeft = ElementAttributes.Direction.NormalizedCoordinate(dx: 0, dy: 1)
	
	/// The bottom right of the element:
	///  _________
	/// |         |
	/// |         |
	/// |         |
	/// |         |
	/// |        *|
	///  ‾‾‾‾‾‾‾‾‾
	static let bottomRight = ElementAttributes.Direction.NormalizedCoordinate(dx: 1, dy: 1)
	
	/// The top third of the element:
	///  _________
	/// |         |
	/// |    *    |
	/// |         |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let topThird = ElementAttributes.Direction.NormalizedCoordinate(dx: 0.5, dy: 0.33)
	
	/// The left third of the element:
	///  _________
	/// |         |
	/// |         |
	/// |  *      |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let leftThird = ElementAttributes.Direction.NormalizedCoordinate(dx: 0.33, dy: 0.5)
	
	/// The bottom third of the element:
	///  _________
	/// |         |
	/// |         |
	/// |         |
	/// |    *    |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let bottomThird = ElementAttributes.Direction.NormalizedCoordinate(dx: 0.5, dy: 0.66)
	
	/// The right third of the element:
	///  _________
	/// |         |
	/// |         |
	/// |      *  |
	/// |         |
	/// |         |
	///  ‾‾‾‾‾‾‾‾‾
	static let rightThird = ElementAttributes.Direction.NormalizedCoordinate(dx: 0.66, dy: 0.5)
	
}
