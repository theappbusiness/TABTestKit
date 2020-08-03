//
//  CGVector+Offset.swift
//  Pods-TABTestKit_Example
//
//  Created by Kane Cheshire on 15/10/2019.
//

import CoreGraphics

public extension CGVector {
	
	/// Offsets the vector by the specified deltas.
	///
	///
	/// - Parameters:
	///   - dx: The amount to offset on the X axis.
	///   - dy: The amount to offset on the Y axis.
	func offset(dx: CGFloat, dy: CGFloat) -> CGVector {
		return CGVector(dx: self.dx + dx, dy: self.dy + dy)
	}
	
}
