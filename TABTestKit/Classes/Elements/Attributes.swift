//
//  Attributes.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

public enum ElementAttributes {
	
	public enum State {
		
		case exists
		case doesNotExist
		
		case hittable
		case notHittable
		
		case visible
		case notVisible
		
		case selected
		case notSelected
		
		case enabled
		case disabled
		
	}

	public enum Direction {
		
		case upwards
		case downwards
		case left
		case right
		
	}
	
}
