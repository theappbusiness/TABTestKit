# CHANGELOG

## Pending

- Clears launch arguments and launch environment values as part of tearDown, ready for the next test.
- Added new `ActivitySheet` to represent the `UIActivityViewController` sheet.
- Added support for `Carthage`, which allows project to use TABTestKit using `Carthage` as their dependency manager.
- Renames `func keyboard(isType type: Keyboard.KeyboardType)` to `func keyboardType(is type: Keyboard.KeyboardType)` to avoid conflict with `public let keyboard = Keyboard()` within `KeyboardContext`.

---

## 1.1.0

### New features

- Added option to provide multiple states when using `InteractionContext` to scroll until an element in a particular state or multiple states.
- Added option to scroll until some element is _not_ in a state (or multiple states).
- Added a new `visibleIn` `State` case, which takes a different element that the element must be visible in, unlike the existing `visible` case which just uses whatever the `parent` element is.
- Added a new  `from(to)` `Direction` case, which allows you to provide a `from` and `to` coordinate to scroll from and to. This is useful, for example, when trying to avoid the keyboard while scrolling.
- Added `CGVector` helper constants for representing various positions in the element's space, like `.middle`, `.topLeft`, `.bottomThird`. These can be used on their own, or with the new `Direction` case mentioned above.
- Updated the docs for `CellContaining` to be clearer about how it works with cell reuse.
- Added a new `ScrollableScreen` protocol, which is a special protocol you can make your screen structs conform to instead of `Screen`. To conform to `ScrollableScreen`, your `trait` _must_ be any element that is also `Scrollable` (like `ScrollView` or `Table`). By doing that, you automatically get scrolling behaviour on the screen so you can pass the screen instance in directly to `InteractionContext` when scrolling.
- Added new `Keyboard` element, which can be used anywhere that `Element` can, and more usefully be used to assert to right keyboard type is shown on-screen. You can also use `Keyboard` to find the `topCoordinate` of it to avoid it while scrolling or performing gestures.
- Since there can only be one software keyboard shown on-screen at one time, an instance is globally available in your tests.
- Added new `KeyboardContext` which `TABTestCase` already conforms to.
- Added `frameInScreen` property to all `Element`s, which allows you to use the `CGRect` of the element in relation to the device's screen.
- Improved the default `Scrollable` implementation to avoid the keyboard while scrolling.

### Fixed

- Added a workaround for iOS 13, where `UILabel`s with the `.header` accessibility trait are always seen as `.staticText` by `XCUI` regardless.

---

## 1.0.0

Initial release of TABTestKit, check out the [README](/README.md)!
