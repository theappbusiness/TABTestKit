//
//  Image.swift
//  Pods-TABTestKit_Example
//
//  Created by Zachary Borrelli on 26/06/2020.
//

import XCTest

/// Represents an image element
public struct Image: Element, ValueRepresentable {

    public let id: String?
    public let index: Int
    public let parent: Element
    public let type: XCUIElement.ElementType = .image
    public var value: String? { return underlyingXCUIElement.label }

    public init(id: String? = nil, index: Int = 0, parent: Element = App.shared) {
        self.id = id
        self.index = index
        self.parent = parent
    }

}
