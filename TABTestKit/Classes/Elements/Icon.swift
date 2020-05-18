//
//  Icon.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 18/05/2020.
//

import XCTest

/// Represents an icon, like an app icon on the Home Screen.
public struct Icon: Element, Tappable {

    public let id: String?
    public let index: Int
    public let parent: Element
    public let type: XCUIElement.ElementType = .icon

    init(id: String? = nil, index: Int = 0, parent: Element = App.shared) {
        self.id = id
        self.index = index
        self.parent = parent
    }

}

public extension Icon {

    /// Represents the icon on the home screen for the UI test runner.
    static let testRunner = Icon(id: Bundle.main.appName, parent: springboard)

}

extension Bundle {

    var appName: String { return infoDictionary?["CFBundleName"] as? String ?? "" }

}
