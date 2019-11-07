# CHANGELOG

## Pending

- Added option to provide multiple states when using `InteractionContext` to scroll until an element in a particular state or multiple states.
- Added option to scroll until some element is _not_ in a state (or multiple states).
- Added a new `visibleIn` `State` case, which takes a different element that the element must be visible in, unlike the existing `visible` case which just uses whatever the `parent` element is.
- Added a new  `from(to)` `Direction` case, which allows you to provide a `from` and `to` coordinate to scroll from and to. This is useful, for example, when trying to avoid the keyboard while scrolling.
- Added `CGVector` helper constants for representing various positions in the element's space, like `.middle`, `.topLeft`, `.bottomThird`. These can be used on their own, or with the new `Direction` case mentioned above.
- Updated the docs for `CellContaining` to be clearer about how it works with cell reuse.
- Added a new `ScrollableScreen` protocol, which is a special protocol you can make your screen structs conform to instead of `Screen`. To conform to `ScrollableScreen`, your `trait` _must_ be any element that is also `Scrollable` (like `ScrollView` or `Table`). By doing that, you automatically get scrolling behaviour on the screen so you can pass the screen instance in directly to `InteractionContext` when scrolling.
- Added a workaround for iOS 13, where `UILabel`s with the `.header` accessibility trait are always seen as `.staticText` by `XCUI` regardless.

---

## 1.0.0

Initial release of TABTestKit, check out the [README](/README.md)!
