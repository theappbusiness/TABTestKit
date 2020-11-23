//
//  NavigationContext.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 09/09/2019.
//

import XCTest

public protocol NavigationContext {}
public extension NavigationContext {
	
	/// Asserts that a screen can be seen, by awaiting on its trait.
	///
	/// - Parameter screen: The screen to await.
	func see<ScreenType: Screen>(_ screen: ScreenType) -> StepAction {
        return StepAction(description: "see the \(screen.description)") {
            screen.trait.await(.exists, .visible)
        }
	}
	
	/// Asserts that a screen does not exist, by awaiting on its trait.
	///
	/// - Parameter screen: The screen to await.
	func doNotSee<ScreenType: Screen>(_ screen: ScreenType) -> StepAction {
        return StepAction(description: "do not see the \(screen.description)") {
            screen.trait.await(not: .exists)
        }
	}
	
	/// Asserts that an element can be seen, by awaiting for it to exist and be visible.
	///
	/// - Parameter element: The element to await.
	func see(_ element: Element) -> StepAction {
        return StepAction(description: "see the \(element.description)") {
            element.await(.exists, .visible)
        }
	}
	
	/// Asserts that an element does not exist, by waiting for it to not exist.
	///
	/// - Parameter element: The element to await.
	func doNotSee(_ element: Element) -> StepAction {
        return StepAction(description: "do not see the \(element.description)") {
            element.await(not: .exists)
        }
	}
	
	/// Completes one or more things that knows how to complete itself.
	///
	/// - Parameter completableThings: One or more Completable things. Typically, this would be a Screen that conforms to Completable.
    func complete<CompletableWithDescription: Completable & CustomStringConvertible>(_ completableThings: CompletableWithDescription...) -> StepAction {
        
		guard !completableThings.isEmpty else { XCTFatalFail("You must provide at least one Completable thing to complete!") }

        let completableDescription = completableThings
            .map { $0.description }
            .joined(separator: " and the ")

        return StepAction(description: "complete the \(completableDescription)") {
            completableThings.forEach {
                $0.await()
                $0.complete()
            }
        }
	}
	
	/// Dismisses one or more things that knows how to complete itself.
	///
	/// - Parameter dismissableThings: One or more Dismissable things. Typically, this would be a Screen that conforms to Dismissable.
	func dismiss<DismissableWithDescription: Dismissable & CustomStringConvertible>(_ dismissableThings: DismissableWithDescription...) -> StepAction {

		guard !dismissableThings.isEmpty else { XCTFatalFail("You must provide at least one Dismissable thing to dismiss!") }

        let dismissableDescription = dismissableThings
            .map { $0.description }
            .joined(separator: " and the ")

        return StepAction(description: "dismiss the \(dismissableDescription)") {
            dismissableThings.forEach {
                $0.await()
                $0.dismiss()
            }
        }
    }
    
    /// Opens the specified URL from the test runner app.
    /// This means you can use this function for testing deep linking, as well as opening web urls in Safari.
    /// This function will first show the Home Screen if necessary, launch the test runner (after finding the correct
    /// page with the runner) and then open the URL.
    ///
    /// It is your responsibility/choice if you want to leave your app in the current state before the test runner
    /// opens the URL, or whether you want to completely terminate your app before hand.
    ///
    /// This leaves you free to test deep linking behaviour from the current state of the app.
    /// or a fresh launch of the app.
    ///
    /// Since you can pass any URL to this function, you could pass an app-specific url like `myapp://deep-link`, or
    /// a regular HTTP link like `https://apple.com`.
    ///
    /// HTTP links are opened in Safari by default, unless you have an app installed that can intercept them using
    /// Universal Links.
    ///
    /// - Parameter url: The URL to open.
    func open(_ url: URL) -> StepAction {
        return StepAction(description: "open '\(url.absoluteString)'") {
            springboard.activate()
            if !Icon.testRunner.determine(.hittable, timeout: 1) {
                XCUIDevice.shared.press(.home) // Ensure we're on the first page of the home screen
                sleep(1)
                while !Icon.testRunner.determine(.hittable, timeout: 1) {
                    springboard.swipeLeft()
                }
            }
            Icon.testRunner.tap()
            sleep(1)
            UIApplication.shared.open(url)
            let openAppConfirmationAlert = Alert(id: "“\(Bundle.main.appName)” wants to open “\(App.shared.name)”", parent: springboard)
            if openAppConfirmationAlert.determine(.exists, timeout: 1) {
                sleep(1)
                openAppConfirmationAlert.actionButton(withID: "Open").tap()
            }
        }
    }
    
}
