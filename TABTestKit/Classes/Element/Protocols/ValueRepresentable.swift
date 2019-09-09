//
//  ValueRepresentable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

/// Represents a type that has a value.
public protocol ValueRepresentable {
	
	associatedtype Value
	/// The value.
	var value: Value { get }
	
}
