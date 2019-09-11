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
		
	}

	public enum Direction {
		
		case up
		case down
		case left
		case right
		
	}
	
}
