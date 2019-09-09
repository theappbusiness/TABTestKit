//
//  NavigationContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import Foundation

public protocol NavigationContext {}
public extension NavigationContext {
	
	func see<ScreenType: Screen>(_ screen: ScreenType) {
		screen.await()
	}
	
	func complete<ScreenType: Completable & Screen>(_ screen: ScreenType) {
		screen.await()
		screen.complete()
	}
	
	func dismiss<ScreenType: Dismissable & Screen>(_ screen: ScreenType) {
		screen.await()
		screen.dismiss()
	}
	
}
