//
//  ActivitySheet.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 11/12/2019.
//

import XCTest

/// Represents the activity sheet (UIActivityViewController), sometimes called
/// the share sheet.
public struct ActivitySheet: Element {
  
  public let id: String? = "ActivityListView"
  public let type: XCUIElement.ElementType = .other
  public let parent: Element
  
  public init(parent: Element = App.shared) {
    self.parent = parent
  }
  
  /// Returns a cancel button that can be tapped to dismiss the sheet.
  /// ActivitySheet is also Dismissable so you can use it with NavigationContext directly.
  public var cancelButton: Button {
    if #available(iOS 13, *) {
      return Button(id: "Close", parent: self)
    } else {
      return Button(id: "Cancel") // On iOS 12, the cancel button sits outside the hierarchy for ActivityListView :(
    }
  }
  
}

extension ActivitySheet: Dismissable {
  
  public func dismiss() {
    cancelButton.tap()
  }
  
}
