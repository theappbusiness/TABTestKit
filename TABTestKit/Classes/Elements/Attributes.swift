//
//  Attributes.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation
import CoreGraphics.CGGeometry

/// Serves as the namespace for Element, since you can't nest enums in a protocol.
public enum ElementAttributes {
	
	/// Represents a state that an element can be in.
	///
	/// - exists: The element exists, but may not necessarily be visible or hittable. It's often a good idea to check this state first to avoid flakiness.
	/// - hittable: The element is hittable, i.e. can be tapped.
	/// - visible: The element is visible in its parent.
	/// - visibleIn: The element is visible in the provided element.
	/// - selected: The element is selected.
	/// - enabled: The element is enabled.
	/// - hasKeyboardFocus: The element has keyboard focus (accepting keyboard entry or user input)
	public enum State {
		
		case exists
		case hittable
		case visible
		case visibleIn(Element)
		case selected
		case enabled
		case hasKeyboardFocus
		
	}

	/// Represents a direction.
	///
	/// - upwards: Up
	/// - downwards: Down
	/// - left: Left
	/// - right: Right
	/// - from: A case allowing you to provide your own coordinates from and to as a direction, i.e. from .topLeft to .bottomRight
	public enum Direction {
		
		/// Represents a normalized coordinate, i.e. 0 - 1.
		///
		/// On the X-axis, 0 is left-most, and 1 is right-most.
		/// On the Y-axis, 0 is top-most, and 1 is bottom-most.
		///
		/// - See also: NormalizedCoordinate+Locations.swift
		public typealias NormalizedCoordinate = CGVector
		
		case upwards
		case downwards
		case left
		case right
		case from(NormalizedCoordinate, to: NormalizedCoordinate)
		
	}
	
}
