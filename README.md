![The App Business](Assets/logo.png)

# TABTestKit

[![Build Status](https://travis-ci.org/theappbusiness/TABTestKit.svg?branch=master)](https://travis-ci.org/theappbusiness/TABTestKit)
[![Version](https://img.shields.io/cocoapods/v/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)
[![License](https://img.shields.io/cocoapods/l/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)
[![Platform](https://img.shields.io/cocoapods/p/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)

TABTestKit is an extremely human readable, strongly typed wrapper, around XCUI/XCTest for automation of
Apple platforms.

```swift
func test_login() {
  Scenario("Register for the app") {
    Given(I: amNotRegistered)
    When(I: registerForTheApp)
    Then(I: see(the: loginScreen))
  }

  Scenario("Logging in successfully with biometrics") {
    Given(I: see(the: loginScreen.logInButton))
    And(the: deviceBiometricsAreEnabled)
    When(I: tap(loginScreen.logInButton))
    And(I: successfullyAuthenticateBiometrics)
    Then(I: see(the: profileScreen))
  }
}
```

## Why?

TABTestKit makes it so you can write very little code to automate the behaviours
in your app, as well as being extremely human readable by leveraging powerful
Swift features. This means the barrier to entry for Swift automation is
essentially removed.

Unlike XCTest, where every XCUIElement can be tapped, adjusted, typed into or scrolled,
regardless of whether it's adjustable etc, TABTestKit has specific elements that
represent common UIKit and AppKit elements, like `Button`, `Slider` and `ScrollView`.

TABTestKit comes with most common elements out the box, but is also completely customisable
by either creating your own custom elements, or by extending existing elements.

The framework is intended to make it so easy to write automation, but also make
it really difficult to write bad automation or make mistakes.

For example, TABTestKit introduces the concept of _parent_ elements, so that you're
always trying to reference the correct element within the right context.
This becomes really important when matching buttons by their labels, where you could
have multiple buttons on screen with the same text (i.e. on the screen and in an alert, like "OK").

TABTestKit also provides a BDD-style approach to writing tests, which mean you
can write Steps, grouped inside Scenarios, which mean that people with very little
coding skills can still get involved and write automation.

You can mix and match whatever parts of TABTestKit you want in your project, so you're not
limited by the framework.

See the example app for real examples on how TABTestKit could be used to leverage writing
automation with not much custom code.

## Usage

There are several components to TABTestKit, which you can pick and choose to use.

### TABTestCase

TABTestCase is the base test case you should make all your test cases subclass:

```swift
class MyTestCase: TABTestCase {

  func test_something() {
    // Your tests here
  }

}
```

By inheriting from `TABTestCase`, you get a lot of setup behaviour for free, like
device biometrics being unenrolled ready for the next test, as well as a UUID
set as a launch environment variable that you can use to uniquely identify your
app instance in parallel tests.

This is useful for mock servers, so that you can tailor the
mock server's responses for each running instance.

`TABTestCase` automatically launches and terminates your app at the start and end
of each test. You can delay the launch or termination to provide extra setup (like
resetting a mock server), by overriding `preLaunchSetup` or `preTerminationTearDown`:

```swift
class MyTestCase: TABTestCase {

  override func preLaunchSetup(_ launch: @escaping () -> Void) {
    // Some pre-launc setup code
    launch()
  }

  func test_something() {
    // Your tests here, that will be executed after `launch()` is called above
  }

}
```

> **NOTE**: If you override `preLaunchSetup` or `preTerminationTearDown` and need to do some asynchronous work before launching or terminating the app, you will need to force the tests to wait until the task is complete, by using `XCTWaiter`.

### Steps and Scenarios

A huge part in making your tests human readable so they're approachable by everyone,
is to write them as Steps and Scenarios.

Steps & Scenarios are a core part of what makes TABTestKit great, and you can choose
to just use Steps & Scenarios without the rest of TABTestKit if you prefer.

#### Steps

Steps are individual functions that run in your tests, like this:

```swift
func test_serverErrorLoggingIn() {
  Given(the: mockServer(is: .failing)))
  When(I: logIn))
  Then(I: seeAnError))
}

// Somewhere else in code:

enum MockServerState {
  case failing
  case succeeding
}

func mockServer(is state: MockServerState) {
  // Code to set the mock server state
}

func logIn() {
  // Code to try and log in
}

func seeAnError() {
  // Code to assert the error screen is showing
}
```

The syntax for the steps above might seem a bit odd to Swift developers.
`Given`/`When`/`Then` are actually just a `typealias` of a `Step` struct, which has
an `init` that takes any function, which is executed automatically by the step.

What's really nice, is that you can _pass a function by reference_, which essentially
means you can drop the `()` for step functions that have no parameters,
to make your code super human readable.

#### Scenarios

Scenarios wrap groups of steps into logical groups, with a description, so that
you can skim read your test functions to find the area of code you're looking for:

```swift
func test_serverErrorLoggingIn() {
  Scenario("Attempting log in when the server is failing") {
    Given(the: mockServer(is: .failing)))
    When(I: logIn))
    Then(I: seeAnError))
  }

  Scenario("Dismissing the error screen") {
    Given(I: seeAnError))
    When(I: dismissTheError))
    Then(I: seeTheLoginScreen))
  }
}
```

### Biometrics

TABTestKit makes it possible and very easy to automate iOS biometrics in the simulator.

You can enable or disable device biometrics:

```swift
Biometrics.enrolled()
Biometrics.unenrolled()
```

> **NOTE:** The term "enrolement" comes from the Simulator menu options to enable or disable biometrics.

You can also simulate a successful or unsuccessful authentication:

```swift
Biometrics.successfulAuthentication()
Biometrics.unsuccessfulAuthentication()
```

This works for both Face ID and Touch ID simulators, but will not work on
a physical device.

> **NOTE:** The example app has an example on how to successfully grant permissions for Face ID during a test.

### Screens & Elements

#### Screens

A `Screen` in TABTestKit represents a screen in your app (i.e. a UIViewController),
and is a really nice way to clearly define the structure of your screens for automation
tests.

It's a little bit like SwiftUI, where you describe what elements make your screen.

To define a screen, simply create a `struct` which conforms to `Screen`:

```swift
struct ProfileScreen: Screen {

  let trait = Header(id: "My Profile")

}
```

A Screen has one required property for you to implement, which is its trait. A
trait any [Element](#elements) that consistently identifies the screen, and is used to `await`
for it to appear on-screen during tests when using [contexts](#contexts).

#### Elements

`Element`s in TABTestKit represent all the different elements on-screen, like `View`s,
`Header`s, `Slider`s, `Alert`s, and so on.

Unlike XCTest where all `XCUIElement` objects can be tapped, scrolled and typed into,
an `Element` in TABTestKit declares whether it is scrollable (i.e. `ScrollView`,
`TextView`, `TableView` etc), whether it has a value (i.e. `Header`, `Label`, `Switch` etc)
and so on.

You can use elements to describe your screen:

```swift
struct ProfileScreen: Screen {

  let trait = Header(id: "My Profile")
  let logOutButton = Button(id: "Log out")
  let nameLabel = Label(id: "Kane Cheshire")
  let changePasswordField = SecureTextField(id: "ChangePasswordField")

}
```

Once you've created your screen, you can use it in tests to interact with the elements:

```swift
let profileScreen = ProfileScreen()
profileScreen.await() // Makes sure the screen is visible before going any further by waiting for its trait
profileScreen.logOutButton.tap() // You can't call tap on an element that isn't `Tappable`, but `Button` is!
```

All elements conform to the `Element` protocol which ensures that every element
has a parent element (defaults to the `App`), underlying `type`, `index` (defaults to `0`),
and has an optional ID.

TABTestKit uses this information to automatically query XCTest for the right `XCUIElement`
when you want to use it, using the parent element as the root. This is all done automatically,
so you don't have to learn about `XCUIElementQuery` to get started.

#### Parent Elements

Because all elements must have a parent, this makes it very powerful for making sure you
are referencing the right element, when there might be multiple matches on screen.

An example of this is when finding the buttons in an alert. Using XCTest it's easy
and common to just look for the first match of a button with the button label as its ID,
like "OK":

```swift
XCUIApplication().buttons["OK"].firstMatch
```

It's very likely there could be other buttons on screen with "OK", so the right button might
not be matched, or it might be the wrong alert with an OK button.

TABTestKit makes it much harder to reference the wrong button, because you use the `Alert`
element to interact with the buttons contained within it:

```swift
let alert = Alert(id: "An error occurred!")
alert.actionButton(withID: "OK").tap()
```

In the above test, there's no way the OK button could be referencing anything other
than a button in the alert, since `Alert` vends you a `Button`, with the `Alert` as
the `parent`.

You can also set the parent of an element yourself:

```swift
let customView = View(id: "CustomView") // By default, the `App` is the parent of `Element`s
let button = Button(id: "OK", parent: customView) // Now only OK buttons within customView will be matched
```

TABTestKit automatically builds the `XCUIElementQuery` under the hood for you
(although you [can do it yourself](#creating-your-own-elements) if you want),
so all you have to do is describe your UI.

Using `Element`s and other protocols like [Tappable](#tappable) has even more
benefits when using [contexts](#contexts) that you can read about in
the [`InteractionContext`](#interactioncontext) documentation.

#### Creating your own Elements

TABTestKit comes with a lot of common elements that you can use to represent and
interact with your UI, but you can also create custom elements if none of the
predefined elements works for you.

To create your own, you can create a struct that conforms to the `Element` protocol:

```swift
struct MyCustomElement: Element {

  // Required Element properties

  let id: String? // The ID of the element
  let type: XCUIElement.ElementType = .other // The underlying type of the element. TABTestKit uses this to build the XCUIElementQuery.

}
```

To conform to `Element` the only things you _must_ provide yourself are the optional
ID, and the underlying `XCUIElement.ElementType`.

That's enough information for TABTestKit to build the underlying XCUIElementQuery,
since the other optional `Element` properties have defaults.

If you need more control, you can always provide more information yourself:

```swift
struct MyCustomElement: Element {

  // Required Element properties

  let id: String?
  let type: XCUIElement.ElementType = .other

  // Optional Element properties

  let parent: Element // The parent Element. You can provide any Element or an app that inherits from BaseApp. By default this is the app under test.
  let index: Int // The index of the Element. By default this is 0, meaning the first match.
  let label: String // The label of the Element. By default this uses the accessibilityLabel of the underlying XCUIElement.
  let underlyingXCUIElement: XCUIElement // The underlying XCUIElement used to interact with the element. By default this is generated for you using the other properties, so you should rarely need to access this or generate it yourself, but you can if you want :)

}
```

#### Extending existing Elements

By default, Elements in TABTestKit don't support any interaction (unless you use
the `underlyingXCUIElement`). Elements that support interaction declare that by
conforming to other protocols, like how [`Button`](#button) conforms to both `Element` and `Tappable`.

If you need extra behaviour for any element you can create an extension and provide
more functionality, either by conforming to another protocol or creating new properties
and functions:

```swift
extension Button {

  func doubleTap() {
    underlyingXCUIElement.doubleTap()
  }

}
```

If you feel like there is behaviour or enchancements that should be made to an Element,
you're encouraged to raise an issue on the repo or create a pull request so other
people can benefit from the enhancement.

### Predefined Elements

#### View

`View` represents a generic view in the app:

```swift
let view = View(id: "MyCustomView")
```

Generally, you'd use a `View` either as the trait of a [`Screen`](#screens) by
setting an identifier on a `UIViewController`'s view:

```swift
func viewDidLoad() {
  super.viewDidLoad()
  view.accessibilityIdentifier = "MyCustomView"
}
```

Or you might use a `View` as a container view (particularly useful
for [`SegmentedControl`](#segmentedcontrol)).

#### Header

`Header` represents a title or header in the app:

```swift
let header = Header(id: "My header text")
let header = Header(id: "MyHeaderIdentifier")
```

You can use either the `Header`'s text or a custom ID as the identifier.

For TABTestKit and XCTest to be able to find your `Header`, your UIKit view
must have the header trait set:

```swift
let myHeaderLabel = UILabel()
myHeaderLabel.accessibilityTraits = .header
```

By doing this, not only does your UI make more semantic sense, it also means
accessibility users can also navigate better. Win-win!

Some UIKit views already have this trait set, like headers in `UITableView` or
the title in a `UINavigationBar`.

#### Label

`Label` represents a generic text label in the app:

```swift
let label = Label(id: "My label text")
let label = Label(id: "MyLabelIdentifier")
```

Like [`Header`](#header) you can use either the `Label`'s text or a custom ID
as the identifier.

For TABTestKit and XCTest to be able to find your `Label`, your UIKit view
must have the staticText trait set:

```swift
let myLabel = UILabel()
myLabel.accessibilityTraits = .staticText
```

For the most part this will be done for you unless you're doing something custom.

#### Button

`Button` represents a button in the app:

```swift
let button = Button(id: "My button text")
let button = Button(id: "MyButtonIdentifier")
```

Like [`Header`](#header) and [`Label`](#label) you can use either the `Button`'s
text or a custom ID as the identifier.

Since `Button` conforms to `Tappable`, you can tap it:

```swift
button.tap()
```

For TABTestKit and XCTest to be able to find your `Label`, your UIKit view
must have the staticText trait set:

```swift
let myButton = UIButton()
myButton.accessibilityTraits = .button
```

For the most part this will be done for you unless you're doing something custom,
you might want to set this trait yourself on a custom view that has a tap gesture
recognizer, for example.

#### ScrollView

`ScrollView` represents a scroll view in the app:

```swift
let scrollView = ScrollView()
let scrollView = ScrollView(id: "MyScrollView")
```

Because it's common to only have one scroll view on screen at once, you don't
need to provide an ID to create one in TABTestKit, unless you need to.

Since `ScrollView` conforms to `Scrollable`, you can scroll it:

```swift
scrollView.scroll(.downwards)
```

#### Table

`Table` represent a table view in the app:

```swift
let table = Table()
let table = Table(id: "MyTable")
```

Like [`ScrollView`](#scrollview), since it's common for there to only be one
table view on screen at once, you don't need to provide an ID to create one.

Since `Table` conforms to `Scrollable`, you can scroll it:

```swift
table.scroll(.upwards)
```

Since `Table` also conforms to `CellContaining`, you can retrieve the number of
cells:

```swift
let allCellsCount = table.numberOfCells()
let allCellsCountMatchingID = table.numberOfCells(matchingID: "MyTableCellID")
```

As well as retrieve a [`Cell`](#cell) for an index:

```swift
let firstCell = table.cell(index: 0)
let lastCell = table.cell(index: allCellsCount - 1)

let firstCellWithID = table.cell(matchingID: "MyTableCellID", index: 0)
let lastCellWithID = table.cell(matchingID: "MyTableCellID", index: allCellsCountMatchingID - 1)
```

#### CollectionView

`CollectionView` represent a collection view in the app:

```swift
let collectionView = CollectionView()
let collectionView = CollectionView(id: "MyCollectionView")
```

Like [`ScrollView`](#scrollview) and [`Table`](#table), since it's common for
there to only be one collection view on screen at once,
you don't need to provide an ID to create one.

Since `CollectionView` conforms to `Scrollable`, you can scroll it:

```swift
collectionView.scroll(.left)
```

Since `CollectionView` also conforms to `CellContaining`, you can retrieve the number of
cells:

```swift
let allCellsCount = collectionView.numberOfCells()
let allCellsCountMatchingID = collectionView.numberOfCells(matchingID: "MyCollectionViewCellID")
```

As well as retrieve a [`Cell`](#cell) for an index:

```swift
let firstCell = collectionView.cell(index: 0)
let lastCell = collectionView.cell(index: allCellsCount - 1)

let firstCellWithID = collectionView.cell(matchingID: "MyCollectionViewCellID", index: 0)
let lastCellWithID = collectionView.cell(matchingID: "MyCollectionViewCellID", index: allCellsCountMatchingID - 1)
```

#### Cell

`Cell` represents a cell in the app. A cell is typically in a table or collection view.

Although you can create a Cell yourself with a [`Table`](#table) or [`CollectionView`](#collectionview)
(or any other `Element`) as a parent:

```swift
let table = Table()
let cell = Cell(index: 0, parent: table)
```

It's better to just ask the `Table` or `CollectionView` for the cell, which will
automatically have the right parent:

```swift
let tableCell = table.cell(index: 0)
let collectionViewCell = collectionView.cell(index: 0)
```

Since `Cell` conforms to `Tappable`, you can tap it:

```swift
table.cell(index: 0).tap()
```
#### TextField

`TextField` represents a regular text field in the app:

```swift
let textField = TextField(id: "MyTextField")
```

> **NOTE:** UITextFields that have secure entry should be represented by a
[`SecureTextField`](#securetextfield)

Since `TextField` conforms to [`Editable`](#editable), you can type into or delete
text from it:

```swift
textField.type("Hello!")
textField.delete(numberOfCharacters: 6)
```

Since `TextField` also conforms to [`Tappable`](#tappable), you can tap it:

```swift
textField.tap()
```

And since `TextField` also conforms to [`ValueRepresentable`](#valuerepresentable),
you can also retrieve the `String` value:

```swift
XCTAssertEqual(textField.value, "Hello!")
```

#### SecureTextField

`SecureTextField` represents a secure text field in the app (i.e. a password field):

```swift
let secureTextField = SecureTextField(id: "MySecureTextField")
```

Since `SecureTextField` conforms to [`Editable`](#editable), you can type into
or delete text from it:

```swift
secureTextField.type("Password1")
secureTextField.delete(numberOfCharacters: 6)
```

Since `SecureTextField` also conforms to [`Tappable`](#tappable), you can tap it:

```swift
secureTextField.tap()
```

And since `SecureTextField` also conforms to [`ValueRepresentable`](#valuerepresentable),
you can also retrieve the `String` value:

```swift
XCTAssertEqual(secureTextField.value, "•••••••••") // Not sure how useful this is but you can assert it if you want 😂
```

#### TextView

`TextView` represents a text view in the app:

```swift
let textView = TextView(id: "MyTextView")
```

Since `TextView` conforms to [`Editable`](#editable), you can type text into or
delete text from it:

```swift
textView.type("Lorem Ipsum")
textView.delete(numberOfCharacters: 12)
```

Since `TextView` also conforms to [`Tappable`](#tappable), you can tap it:

```swift
textView.tap()
```

And since `TextView` also conforms to [`ValueRepresentable`](#valuerepresentable), you can also retrieve
the `String` value:

```swift
XCTAssertEqual(textView.value, "Lorem Ipsum")
```

And since `TextView` also conforms to [`Scrollable`](#scrollable), you can scroll it:

```swift
textView.scroll(.downwards)
```

#### NavBar

`NavBar` represents a navigation bar in your app:

```swift
let navBar = NavBar()
let navBar = NavBar(id: "MyNavBar")
```

Since there's typically only one nav bar on screen at one time, you don't need to
provide an ID, but you can if you like.

`NavBar` can vend you its [`Header`](#header), which you can use to assert the value:

```swift
XCTAssertEqual(navBar.header.value, "Screen Title")
```

#### TabBar

`TabBar` represents a tab bar in your app:

```swift
let tabBar = TabBar()
let tabBar = TabBar(id: "MyTabBar")
```

Since there's typically only one tab bar on screen at one time, you don't need to
provide an ID, but you can if you like.

`TabBar` can vend you its [`Button`s](#button):

```swift
tabBar.button(withID: "Tab 1").tap()
```

Like other `Button`s, the ID for the button can be the button title, or a custom
ID you've set as the `accessibilityIdentifier`.

#### Alert

`Alert` represents an alert (sometimes called popup or dialog) in the app:

```swift
let alert = Alert(id: "My alert title")
let alert = Alert(id: "My alert title", dismissButtonID: "OK")
```

Typically, the ID of an alert is its title. You can also optionally provide a
`dismissButtonID` if your alert is not dismissed with `"Cancel"`.

`Alert` vends you action buttons based on ID, so you can be sure that you're
referencing the correct button on screen:

```swift
alert.actionButton(withID: "Delete").tap()
```

Since `Alert` conforms to [`Dismissable`](#dismissable), you can dismiss it:

```swift
alert.dismiss()
```

> **NOTE:** `Alert` uses the `dismissButtonID` to dismiss itself, which is
`"Cancel"` by default.

#### Sheet

`Sheet` represents an activity sheet in the app:

```swift
let sheet = Sheet(id: "My sheet title")
let sheet = Sheet(id: "My sheet title", dismissButtonID: "OK")
```

Typically, the ID of an sheet is its title. You can also optionally provide a
`dismissButtonID` if your sheet is not dismissed with `"Cancel"`.

`Sheet` vends you action buttons based on ID, so you can be sure that you're
referencing the correct button on screen:

```swift
sheet.actionButton(withID: "Delete").tap()
```

Since `Sheet` conforms to [`Dismissable`](#dismissable), you can dismiss it:

```swift
sheet.dismiss()
```

> **NOTE:** `Sheet` uses the `dismissButtonID` to dismiss itself, which is
`"Cancel"` by default.

#### Switch

`Switch` represents a switch (sometimes called a toggle) in the app:

```swift
let toggle = Switch(id: "MySwitch")
```

Since `Switch` conforms to `ValueRepresentable`, you can get the current state:

```switch
XCTAssertEqual(toggle.value, .on)
XCTAssertEqual(toggle.value, .off)
```

Since `Switch` also conforms to `Adjustable`, you can adjust the state to `on` or `off`:

```switch
toggle.adjust(to: .on)
toggle.adjust(to: .off)
```

Since `Switch` also conforms to `Tappable`, you can tap it:

```switch
toggle.tap()
```

> **NOTE:** TABTestKit fails the test if the value is already the value you're trying
to set it to.

#### Slider

`Slider` represents a slider in the app:

```swift
let slider = Slider(id: "MySlider")
```

Since `Slider` conforms to `ValueRepresentable`, you can get the current `CGFLoat` value:

```swift
XCTAssertEqual(slider.value, 0.5)
```

Since `Slider` also conforms to `Adjustable`, you can set the current `CGFloat` value:

```swift
slider.adjust(to: 1)
```

> **NOTE:** TABTestKit fails the test if the value is already the value you're trying
to set it to.

#### Stepper

`Stepper` represents a stepper in the app:

```swift
let stepper = Stepper(id: "MyStepper")
```

You can interact with the `incrementButton` and `decrementButton` in the `Stepper`:

```swift
stepper.incrementButton.tap()
stepper.decrementButton.tap()
```

Unfortunately, the underlying `XCUIElement` for a `Stepper` does not provide the
current value, so you will need to assert the value using some other element (like
a label).

You can, however, assert the states of the buttons, like checking if the buttons are
enabled:

```swift
stepper.decrementButton.await(not: .enabled, timeout: 1) // Waits a max of 1 second for the button to be disabled
```

You can learn more about `await(not:)` and other `Element` methods in the
documentation for [`Element`](#element).

#### SegmentedControl

`SegmentedControl` represents a segmented control in the app:

```swift
let segmentedControl = SegmentedControl()
```

Unfortunately, UIKit doesn't seem to support setting a custom accessibilityIdentifier
or accessibilityLabel on a `UISegmentedControl`, so you can't reference it by ID like
other elements.

You can get around this by wrapping your `UISegmentedControl` in a container `UIView` and
giving that container view an identifier:

```swift
let segmentedControl = UISegmentedControl()
let containerView = UIView()
containerView.accessibilityIdentifier = "MySegmentedControl"
containerView.addSubview(segmentedControl)
```

And then you can reference that container view as the parent in your tests:

```swift
let segmentedControl = SegmentedControl(parent: View(id: "MySegmentedControl"))
```

Alternatively, you can reference the segmented control by index:

```swift
let segmentedControl = SegmentedControl(index: 0)
let segmentedControl = SegmentedControl(index: 1)
```

`SegmentedControl` vends you segment buttons based on ID, so you can be sure that you're
referencing the correct button on screen:

```swift
segmentedControl.button(withID: "Segment 2").tap()
```

#### PageIndicator

`PageIndicator` represents a page control or page indicator in the app:

```swift
let pageIndicator = PageIndicator(id: "MyPageIndicator")
```

Since `PageIndicator` conforms to `ValueRepresentable`, you can get the string value:

```swift
XCTAssertEqual(pageIndicator.value, "page 1 of 3")
```

#### WebView

`WebView` represents a web view in the app:

```swift
let webView = WebView(id: "MyWebView")
```

Since `WebView` conforms to `Scrollable`, you can scroll it:

```swift
webView.scroll(.left)
```

### Predefined Screens

TABTestKit comes with some helpful predefined screens that you can use in your tests.

#### SystemSettingsRootScreen

The root of the system Settings app. You can use this to navigate
to [`SystemSettingsGeneralScreen`](#SystemSettingsGeneralScreen):

```swift
systemPreferencesRootScreen.generalCell.tap()
```

> **NOTE:** You don't have to create an instance of `SystemSettingsRootScreen`
or other predefined screens, since they have already been created and are globally
available anywhere in your tests.

#### SystemSettingsGeneralScreen

The General screen in system Settings. You can use this to
navigate to [`SystemPreferencesResetScreen`](#SystemPreferencesResetScreen):

```swift
systemSettingsGeneralScreen.resetCell.tap()
```

#### SystemPreferencesResetScreen

The Reset screen in system Settings. You can use this to reset privacy and
permissions prompts, like Face ID permissions:

```switch
systemPreferencesResetScreen.resetCell.tap()
confirmResetSheet.actionButton(withID: "Reset Warnings").tap()
```

### Contexts

Contexts are a way to share reusable code between test cases without having to
either make all functions globally available, or without having to have complicated
inheritances.

A context is just a protocol with pre-implemented functions, so whenever a test case
conforms to it all those functions become available.

TABTestKit comes with many predefined contexts, which `TABTestCase` already conforms
to, so by subclassing TABTestCase, you'll automatically have access to a wealth of
helper functions that work beautifully with [steps and secenarios](#steps-and-scenarios), and [`Element`](#element) and other protocols

Most of the time, you won't even have to write any extra functions yourself, making it
ridiculously fast for you to get automation for your project running.

#### NavigationContext

`NavigationContext` is a predefined context that `TABTestCase` already conforms to,
which means your test cases can already use the functions in it.

`NavigationContext` provides helper functions for navigating through the app:

#### Asserting whether screens are visible

Using `NavigationContext`, you can assert whether any [`Screen`](#screen) is visible:

```swift
see(myScreen)
doNotSee(myScreen)
```

#### Asserting whether elements are visible

Using `NavigationContext`, you can assert whether any [`Element`](#element) is visible:

```swift
see(myScreen.button)
doNotSee(myScreen.button)
```

#### Completing and Dismissing

Using `NavigationContext`, you can complete and dismiss anything that conforms
to [`Completable`](#completable) and [`Dismissable`](#dismissable)

```swift
complete(myScreen)
dismiss(myScreen)

dismiss(myScreen.alert)
```

You can also pass any number of `Completable` or `Dismissable` things into the function, which makes it possible for you to build up a flow through the app really
easily:

```swift
complete(nameScreen, birthDateScren, usernameScreen)
```

## Requirements

TABTestKit has **no dependencies** and supports **iOS 10** and newer. 🎉

## Installation

### Cocoapods

#### Latest

To use the latest version of TABTestKit just add this to your `Podfile` and
run `pod update` or `pod install` in Terminal:

```ruby
pod 'TABTestKit'
```

#### Development

To use the version under development you can target the `develop` branch specifically:

```ruby
pod 'TABTestKit' # TODO: Target branch
```

#### Subspecs

There's 1 subspec available: `Biometrics`. This means you can get a subset of `TABTestKit`'s functionality.

```ruby
pod 'TABTestKit/Biometrics'
```

## Contributing

Guidelines for contributing can be found [here](CONTRIBUTING.md).

## Authors

Neil Horton, neil@theappbusiness.com, https://github.com/neil3079  
Zachary Borrelli, zac@theappbusiness.com, https://github.com/zacoid55  
Kane Cheshire, kane.cheshire@theappbusiness.com, https://github.com/kanecheshire

## License

TABTestKit is available under the MIT license. See the LICENSE file for more info.
