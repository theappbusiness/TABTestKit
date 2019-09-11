//
//  ValueRepresentable.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

public protocol ValueRepresentable {
	
	associatedtype Value: Equatable
	var value: Value { get }
	
}

