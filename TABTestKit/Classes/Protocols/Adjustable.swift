//
//  Adjustable.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 13/09/2019.
//

import Foundation

public protocol Adjustable {
	
	associatedtype Value: Equatable
	func adjust(to value: Value)
	
}
