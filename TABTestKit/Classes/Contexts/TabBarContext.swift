//
//  TabBarContext.swift
//  TABTestKit
//
//  Created by Anna Piktas on 15/12/2020.
//

import Foundation
import XCTest

public protocol TabBarContext {}
public extension TabBarContext {
	
	func numberOfTabs(in tabBar: TabBar, is count: Int) {
		XCTAssertEqual(tabBar.numberOfTabs, count)
	}
	
}
