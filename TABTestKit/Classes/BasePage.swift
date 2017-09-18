//
//  BasePage.swift
//  TABTestKit
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 The App Business LTD. All rights reserved.
//

import XCTest

/// All pages should inherit from this class
protocol PageProtocol {
  var trait: XCUIElement? { get }
}

open class BasePage: GlobalFunctions, PageProtocol {
  
  var trait: XCUIElement?
  
  public override init() {}

  /// Native back button control
  public func tapBackButton() {
    let app = XCUIApplication()
    
    app.navigationBars.children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
  }
  
  /// Use primarily to assert that you're on the correct screen - all screens should try to have a trait element.
  /// If the trait is static it can be decalred in the init() function of a page, if you want it to be dynamic you can pass it an element to use as a trait
  ///
  /// - Parameter trait: An element that can be used as an "anchor" to discern whether you're on that page or not
  public func await(trait: XCUIElement? = nil) {
    if let trait = trait {
      waitForElementToAppear(trait)
    } else if let trait = self.trait {
      waitForElementToAppear(trait)
    }
  }

}
