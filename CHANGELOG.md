# CHANGELOG

## 1.8.0

- Obsoleted the `await` function in Swift 5.5 and added a `waitFor` function because using `await` in Swift 5.5 will lead to ambiguity errors with the `await` keyword. No code changes are required for clients, unless they're on Swift 5.5 and are calling the `await` function in their code. In that case, they will need to update it to `waitFor`.
- Upgraded GitHub actions:
    - Added Xcode 12.1 as part of the job for validating SwiftPM, Carthage and Cocoapods
    - Temporary allow Cocoapods to valid a library with warning for Xcode 12
    - Bumped to Xcode 11.7
    - Added `carthage.sh` to fix the issue with duplicated architecture when Carthage needs to build with Xcode 12.0
- Fixed Carthage issue to allow `Biometics` framework to be seperated from TABTestKit as the same of SwiftPM
- Fixed a timezone issue on TestExample when switching from Summer Time to Winter Time. We make sure that the DatePicker are now always in UTC Timezone
- Added a method to assert the alert message
- Added assert for tab bar tab count

---

## 1.7.1

### Fixed

- Fixed an issue with entering background states on different OS versions. (issue #135)

---

## 1.7.0

- Added support for double tapping, long pressing and two finger tapping, with default implementations for any Elements that conform to Tappable. (issue #88)
- Added Swift Package Manager support
- Added a `Refreshable` protocol so for each element/screen that conforms to protocol `refresh` function can be defined 
- Added a `DatePicker` element. (issue #55)
- Added the ability to access `value` directly from an element

---

## 1.6.1

### Fixed

- `Image.swift` wasn't added to the main framework meaning it wouldn't work for Carthage
- Build issue with brew on Travis' 12.4 image

---

## 1.6.0

- Added `Image` element which can be used to represent images (and anything else that XCUI sees as a `.image` type). (issue #100)
- Added Brewfile for better dependency control
- Fixes an issue when building Carthage framework failed due to a missing file in TABTestKit carthage project.
- Adds a step script for building carthage framework in Travis CI. This should report to CI if the TABTestKit can be build as a Carthage framework.
- Adds a step script for linting cocoapods project in Travis CI. This should report to CI if the TABTestKit can be safe to be published as Cocoapods framework.

---

## 1.5.0

- Added support for deep linking by adding a new function to `NavigationContext` which allows you to pass any `URL` to open, including regular HTTPS or app-specific URLs. (issue #94)
- Added globally available instance of `Springboard` meaning you no longer need to create one every time you want to use `Springboard` as a parent element. (issue #93)
- Added `Icon` element which can be used to represent home screen icons (and anything else that XCUI sees as an `.icon` type). (issue #95)
- Added support for waiting for the app to be in a particular state in `AppContext` (useful for deep linking)

---

## 1.4.0

- Improved error messaging with XCTAssert* calls. The main offender was when waiting for an element to be in a specific state and it would just show an error of `XCTAssertTrue failed`. (issue #80)

---

## 1.3.0

- Better failure reports. Specifically, the most recently executed Step's file / line is used to report a failure (if one exists). This means that the red error banner now shows on the correct line in the correct file, and should report better failures on CI rather than just "assert true failed in Element.swift" etc. (issue #80)

---

## 1.2.1

### Fixed

- Properly clears launch argument indicating that the app should be launched clean when calling `launchTheApp(clean:)` in `AppContext`. (issue #74)
- Fixes an issue when calling `background()` on `BaseApp` on iOS 13 since it never reaches the `runningBackgroundSuspended` state. This is likely a bug in iOS 13 simulators/XCUI but this is fixed by just waiting for `runningBackground` for iOS 13+. (issue #64)

## 1.2.0

### New features

- Clears launch arguments and launch environment values as part of tearDown, ready for the next test.
- Added new `ActivitySheet` to represent the `UIActivityViewController` sheet.
- Added support for `Carthage`, which allows project to use TABTestKit using `Carthage` as their dependency manager.

### Fixed

- Renames `func keyboard(isType type: Keyboard.KeyboardType)` to `func keyboardType(is type: Keyboard.KeyboardType)` to avoid conflict with `public let keyboard = Keyboard()` within `KeyboardContext`.

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
