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
	
	func doNotSee<ScreenType: Screen>(_ screen: ScreenType) {
		screen.trait.await(.doesNotExist)
	}
	
	func complete<ScreenType: Completable & Screen>(_ screens: ScreenType...) {
		screens.forEach { screen in
			screen.await()
			screen.complete()			
		}
	}
	
	func dismiss<ScreenType: Dismissable & Screen>(_ screen: ScreenType) {
		screen.await()
		screen.dismiss()
	}
	
}
