//
//  Attributes.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

/// Serves as the namespace for Element, since you can't nest enums in a protocol.
public enum ElementAttributes {
	
	public enum State {
		
		case exists
		case hittable
		case visible
		case visibleIn(Element)
		case selected
		case enabled
		case hasKeyboardFocus
		
	}

	public enum Direction {
		
		case upwards
		case downwards
		case left
		case right
		case from(from: CGVector, to: CGVector)
		
	}
	
}
