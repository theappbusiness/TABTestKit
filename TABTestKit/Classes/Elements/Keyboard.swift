//
//  Keyboard.swift
//  Pods-TABTestKit_Example
//
//  Created by Kane Cheshire on 14/10/2019.
//

import XCTest

/// A globally available keyboard you can use in your tests, since there's only ever going to be one keyboard on screen at once :)
public let keyboard = Keyboard()

/// Repesents the software keyboard that the system shows.
/// Since the software keyboard can be shown in multiple different formats (numeric, twitter, url etc),
/// you can use this element to assert that the keyboard is being shown in the expected way.
public struct Keyboard: Element {
	
	public enum KeyboardType: CaseIterable {
		case regular
		case numberPad
		case decimalPad
		case emailAddress
		case numbersAndPunctuation
		case phonePad
		case twitter
		case url
		case webSearch
	}
	
	public let id: String? = nil
	public let type: XCUIElement.ElementType = .keyboard
	public let parent: Element
	
	/// The current keyboard type.
	/// Attempting to access this before the keyboard is visible will fail the test.
	public var keyboardType: KeyboardType {
    #if swift(>=5.5)
      waitFor(.exists, .visible)
    #else
		  await(.exists, .visible)
    #endif
		guard let type = KeyboardType.allCases.first(where: expectedKeysExist) else { XCTFatalFail("Unable to determine keyboard type") }
		return type
	}
	
	/// The top coordinate (as a CGVector/NormalizedCoordinate) of the keyboard, in relation to the screen.
	/// You could use this to make sure that you avoid the keyboard when scrolling, for example.
	public var topCoordinate: CGVector {
		return predictionBar.determine(.exists) ? predictionBar.topCoordinate : defaultTopCoordinate
	}
	
	/// Returns the predication bar element. This is useful for knowing if the prediction bar is showing or not, and to find the top coordinate of it.
	public var predictionBar: PredicationBar { return PredicationBar(parent: parent) }
	
	public init(parent: Element = App.shared) { self.parent = parent }
	
	/// Returns a key with the specified id, with the keyboard as the parent.
	/// Since not all keys in the software keyboard are represented with the underlying
	/// XCUIElement.ElementType of `.key` (which is annoying!), you can specify if
	/// the key is actually represented as a `.button`.
	///
	/// - Parameter id: The id of the key to retrieve.
	/// - Returns: A `Key`, with this keyboard as the parent.
	public func key(_ id: String, isActuallyButton: Bool = false) -> Key {
		return Key(id: id, parent: self, isActuallyButton: isActuallyButton)
	}
	
}

public extension Keyboard {
	
	/// Represents a Key that the Keyboard contains.
	struct Key: Element, Tappable {
		
		public let id: String?
		public let type: XCUIElement.ElementType
		public let parent: Element
		
		/// Creates a new Key instance, configured with an ID and a keyboard parent.
		/// Since not all keys in the software keyboard are represented with the underlying
		/// XCUIElement.ElementType of `.key` (which is annoying!), you can specify if
		/// the key is actually represented as a `.button`.
		///
		/// - Parameters:
		///   - id: The id of the key. This could be the accessibilityLabel or accessibilityIdentifier.
		///   - parent: The parent keyboard of the button.
		///   - isActuallyButton: Whether the key is actually represented as a key in XCUI or button.
		public init(id: String, parent: Keyboard, isActuallyButton: Bool = false) {
			self.id = id
			self.type = isActuallyButton ? .button : .key
			self.parent = parent
		}
		
	}
	
	/// Represents the prediction bar above the keyboard.
	/// Rather annoyingly, the prediction bar isn't a child of any keyboard,
	/// just a different window that also contains the keyboard.
	/// Because of this, the `parent` element should _not_ be a `Keyboard`.
	struct PredicationBar: Element {
		
		public let id: String? = "Typing Predictions"
		public let type: XCUIElement.ElementType = .other
		public let parent: Element
		
		init(parent: Element = App.shared) {
			self.parent = parent
		}
		
	}
	
}

public extension Keyboard {
	
	var decimal: Key { return key(".") }
	var a: Key { return key("a") }
	var moreNumbers: Key {
		if #available(iOS 13.0, *) {
			return key("numbers")
		}
		return key("more, numbers")
	}
	var moreLetters: Key {
		if #available(iOS 13.0, *) {
			return key("letters")
		}
		return key("more, letters")
	}
	var phonePadShift: Key { return key("Shift") }
	var space: Key { return key("space") }
	var at: Key { return key("@") }
	var hash: Key { return key("#") }
	var zero: Key { return key("0") }
	var dotCom: Key { return key(".com") }
	var forwardSlash: Key { return key("/") }
	var exclamation: Key { return key("!") }
	
}

private extension Keyboard {
	
	func validKeys(for keyboardType: KeyboardType) -> [Key] {
		switch keyboardType {
		case .regular: return [a, moreNumbers, space]
		case .numberPad: return [zero]
		case .decimalPad: return [decimal, zero]
		case .emailAddress: return [a, moreNumbers, space, at, decimal]
		case .numbersAndPunctuation: return [moreLetters, space, decimal, at, zero, forwardSlash, exclamation]
		case .phonePad: return [phonePadShift, zero]
		case .twitter: return [a, moreNumbers, space, at, hash]
		case .url: return [a, moreNumbers, decimal, forwardSlash, dotCom]
		case .webSearch: return [a, moreNumbers, space, decimal]
		}
	}
	
	func invalidKeys(for keyboardType: KeyboardType) -> [Key] {
		switch keyboardType {
		case .regular: return [decimal, moreLetters, phonePadShift, at, hash, zero, dotCom, forwardSlash, exclamation]
		case .numberPad: return [decimal, moreNumbers, moreLetters, phonePadShift, space, at, a, hash, dotCom, forwardSlash, exclamation]
		case .decimalPad: return [moreNumbers, moreLetters, phonePadShift, space, at, a, hash, dotCom, forwardSlash, exclamation]
		case .emailAddress: return [moreLetters, phonePadShift, hash, zero, dotCom, forwardSlash, exclamation]
		case .numbersAndPunctuation: return [a, moreNumbers, phonePadShift, hash, dotCom]
		case .phonePad: return [decimal, a, moreNumbers, moreLetters, space, at, hash, dotCom, forwardSlash, exclamation]
		case .twitter: return [decimal, moreLetters, phonePadShift, zero, dotCom, forwardSlash, exclamation]
		case .url: return [moreLetters, phonePadShift, space, at, hash, zero, exclamation]
		case .webSearch: return [moreLetters, phonePadShift, at, hash, zero, dotCom, forwardSlash, exclamation]
		}
	}
	
	func expectedKeysExist(for keyboardType: KeyboardType) -> Bool {
		for key in validKeys(for: keyboardType) where !key.underlyingXCUIElement.exists  { return false }
		for key in invalidKeys(for: keyboardType) where key.underlyingXCUIElement.exists { return false }
		return true
	}
	
}
