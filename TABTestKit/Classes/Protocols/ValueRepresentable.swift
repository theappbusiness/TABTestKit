//
//  ValueRepresentable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

/// Represnts a type that has some value.
/// The conforming type decides what that value is by setting
/// the associated value.
public protocol ValueRepresentable {
	
	associatedtype Value: Equatable
	var value: Value { get }
	
}
