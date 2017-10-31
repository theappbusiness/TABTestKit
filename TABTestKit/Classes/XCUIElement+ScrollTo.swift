//
//  XCUIElement+ScrollTo.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 The App Business LTD. All rights reserved.
//

import XCTest

public extension XCUIElement {
  
  func visible() -> Bool {
    guard self.exists && !self.frame.isEmpty else { return false }
    return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
  }
  
  /// This uses a generic call for cells on the page and scrolls to the last one it can find on the page
  func scollToLastCell() {
    let lastCell = cells.element(boundBy: cells.count-1)
    scroll(toElement: lastCell)
  }
  
  /// Scrolls to the given element if that element exists and is hittable. Uses a drag to scroll the page
  ///
  /// - Parameters:
  ///   - element: the element that is to be scrolled to
  ///   - scrollUp: by default this function will scroll down, change this to true to reverse that
  func scroll(toElement element: XCUIElement, scrollUp: Bool = false) {
    var lastMidCellID = ""
    var lastMidCellRect = CGRect.zero
    var currentMidCell = cells.element(boundBy: cells.count / 2)
    
    // Scroll until the requested cell is hittable, or until we try and scroll but nothing changes
    while lastMidCellID != currentMidCell.identifier || !lastMidCellRect.equalTo(currentMidCell.frame) {
      if element.exists && element.isHittable {
        break
      }
      
      lastMidCellID = currentMidCell.identifier
      lastMidCellRect = currentMidCell.frame      // Need to capture this before the scroll
      
      if scrollUp {
        coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.4)).press(forDuration: 0.01, thenDragTo: coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.9)))
      } else {
        coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.9)).press(forDuration: 0.01, thenDragTo: coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.2)))
      }
      currentMidCell = cells.element(boundBy: cells.count / 2)
    }
  }
  
}
