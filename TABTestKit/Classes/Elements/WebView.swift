//
//  WebView.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 12/09/2019.
//

import XCTest

/// Represents a webview in your app.
public struct WebView: Element, Scrollable {
	
	public let id: String?
	public let parent: Element
	public let type: XCUIElement.ElementType = .webView
	
	public init(id: String, parent: Element = App.shared) {
		self.id = id
		self.parent = parent
	}
	
}
