//
//  ValueRepresenting.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

public protocol ValueRepresenting {
	
	associatedtype Value
	var value: Value { get }
	
}
