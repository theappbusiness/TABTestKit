//
//  TableScreen.swift
//  Pods-TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//

import Foundation

/// Represents a screen that has a table, for example a UITableViewController.
public protocol TableDisplaying {
	
	/// The TableScreen's table.
	/// Generally you can conform to TableScreen and get a table for free,
	/// or you can provide your own table.
	var table: Table { get }
	
}

public extension Screen where Self: TableDisplaying {
	
	var table: Table { return Table(parent: app) }
	
}

public extension Screen where Self: TableDisplaying & Scrollable {
	
	func scroll(_ direction: ElementAttributes.Direction) {
		table.scroll(direction)
	}
	
}
