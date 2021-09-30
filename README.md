![TABTestKit - Kin + Carta Create](Assets/logo.png)

# TABTestKit

[![TABTestKit CI](https://github.com/theappbusiness/TABTestKit/workflows/TABTestKit%20CI/badge.svg)](https://github.com/theappbusiness/TABTestKit/actions)
[![Version](https://img.shields.io/cocoapods/v/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License](https://img.shields.io/cocoapods/l/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)
[![Platform](https://img.shields.io/cocoapods/p/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)

**TABTestKit** is an extremely human readable, strongly typed wrapper around XCUI/XCTest for iOS automation,
which helps reduce flakiness and lowers the barrier to entry for most people.

**TABTestKit** also makes it possible to reliably automate iOS [biometrics](#biometrics) for
the first time ever, as well as automate [deep linking into your app](#opening-urls-and-deep-linking), with no external dependencies!

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
    And(the: state(of: loginScreen.loginButton, is: .enabled))
    When(I: tap(loginScreen.logInButton))
    And(I: successfullyAuthenticateBiometrics)
    Then(I: see(the: profileScreen))
  }
}
```

- [Quick Start](#quick-start)
- [Why?](#why)
- [Usage](#usage)
  - [`TABTestCase`](#tabtestcase)
  - [Steps & Scenarios](#steps-and-scenarios)
    - [`Steps`](#steps)
    - [`Scenarios`](#scenarios)
  - [Biometrics](#biometrics)
  - [Screens & Elements](#screens--elements)
    - [Screens](#screens)
    - [Elements](#elements)
      - [Parent Elements](#parent-elements)
      - [Creating your own elements](#creating-your-own-elements)
      - [Extending existing elements](#extending-existing-elements)
    - [Predefined Elements](#predefined-elements)
      - [`View`](#view)
      - [`Header`](#header)
      - [`Label`](#label)
      - [`Button`](#button)
      - [`ScrollView`](#scrollview)
      - [`Table`](#table)
      - [`CollectionView`](#collectionview)
      - [`Cell`](#cell)
      - [`TextField`](#textfield)
      - [`SecureTextField`](#securetextfield)
      - [`TextView`](#textview)
      - [`Keyboard`](#keyboard)
      - [`NavBar`](#navbar)
      - [`TabBar`](#tabbar)
      - [`Alert`](#alert)
      - [`Sheet`](#sheet)
      - [`ActivitySheet`](#activitysheet)
      - [`Switch`](#switch)
      - [`Slider`](#slider)
      - [`Stepper`](#stepper)
      - [`SegmentedControl`](#segmentedcontrol)
      - [`Picker`](#picker)
      - [`DatePicker`](#datePicker)
      - [`PageIndicator`](#pageindicator)
      - [`WebView`](#webview)
      - [`Image`](#image)
    - [Predefined Screens](#predefined-screens)
      - [`systemPreferencesRootScreen`](#systempreferencesrootscreen)
      - [`systemPreferencesGeneralScreen`](#systempreferencesgeneralscreen)
      - [`SystemPreferencesResetScreen`](#systempreferencesresetscreen)
  - [Contexts](#contexts)
    - [`NavigationContext`](#navigationcontext)
    - [`InteractionContext`](#interactioncontext)
    - [`AppContext`](#appcontext)
    - [`AlertContext`](#alertcontext)
    - [`SheetContext`](#sheetcontext)
    - [`KeyboardContext`](#keyboardcontext)
    - [`BiometricsContext`](#biometricscontext)
    - [`SystemPreferencesContext`](#systempreferencescontext)
  - [Protocols](#protocols)
    - [`Screen`](#screen)
    - [`ScrollableScreen`](#scrollablescreen)
    - [`Completable`](#completable)
    - [`Dismissable`](#dismissable)
    - [`Element`](#element)
    - [`Tappable`](#tappable)
    - [`Editable`](#editable)
    - [`Scrollable`](#scrollable)
    - [`ValueRepresentable`](#valuerepresentable)
    - [`Adjustable`](#adjustable)
    - [`CellContaining`](#cellcontaining)
  - [Apps](#apps)
    - [`BaseApp`](#baseapp)
    - [`App`](#app)
    - [`SystemPreferences`](#systempreferences)
    - [`Safari`](#safari)
    - [`Springboard`](#springboard)
- [Installation](#installation)

## Quick start

### Step 1: Create screens that represents your UI

```swift
// ProfileScreen.swift

struct ProfileScreen: Screen {

  let trait = Header(id: "Not Instagram") // The trait of a screen is what consistently and uniquely identifies it. It can be anything that conforms to `Element`
  let usernameLabel = Label(id: "UsernameLabel") // IDs can either be the accessibilityLabel or accessibilityIdentifier of views in the app
  let logOutButton = Button(id: "Log out")

}

let profileScreen = ProfileScreen() // Create an instance of your screen that is globally available
```

### Step 2: Create a test case that subclasses TABTestCase

```swift
// ProfileTests.swift

class ProfileTests: TABTestCase {

  func test_loggingOut() {
  }

}
```

### Step 3: Write steps and scenarios that describe your test

```swift
// ProfileTests.swift

class ProfileTests: TABTestCase {

  func test_loggingOut() {
    Scenario("Logging out") { // Scenarios group steps with a description, so you can have multiple Scenarios in a test function
      Given(I: see(profileScreen)) // Steps can be either Given, When, Then, or And and can take any function which is executed automatically
      And(the: value(of: profileScreen.usernameLabel, is: "My username")) // This `value(of)` function comes for free with TABTestCase!
      When(I: tap(profileScreen.logOutButton))
      Then(I: doNotSee(profileScreen))
    }
  }

}
```

### Step 4: Create more screens, scenarios and steps!

Once you start to define more [`Screen`s](#screen), you can execute longer flows
in your app and start to take advantage of [Scenarios](#scenarios)
and [Steps](#steps), as well as leverage [`Element`s](#elements) and [Contexts](#contexts).

## Why?

**TABTestKit** enables you to write **very little code** to automate the behaviours
in your app, as well as making your tests **extremely human readable** by
leveraging powerful Swift features.

This means the barrier to entry for Swift automation is
hugely reduced, allowing more people on your team contribute to tests.

Additionally, **TABTestKit** makes a habit to _wait_ for things, rather than asserting
immediately, which **massively reduces flakiness in your tests**.

Unlike XCTest, where every `XCUIElement` can be tapped, adjusted, typed into or scrolled,
regardless of whether it's adjustable etc, **TABTestKit** has specific elements that
represent common UIKit and AppKit elements, like [`Button`](#button), [`Slider`](#slider)
and [`ScrollView`](#scrollview).

**TABTestKit** comes with most common elements out the box, but is also **completely customisable**,
either by [creating your own custom elements](#creating-your-own-elements), or by [extending existing elements](#extending-existing-elements).

The framework is intended to make it as quick as possible to write automation,
but also make it difficult to write bad, flaky automation, or make mistakes.

For example, **TABTestKit** introduces the concept of `parent` elements, so that you're
always trying to reference the correct element within the appropriate parent.
This becomes really important when matching buttons by their labels, where you could
have multiple views with the same text (i.e. on the screen and in an alert, like `"OK"`).

**TABTestKit** also provides a BDD-style approach to writing tests, which mean you
can write [Steps](#steps), grouped inside [Scenarios](#scenarios), which means
that people with very little coding experience can still get involved and write automation,
because it reads (mostly) like English.

You can mix and match whatever parts of **TABTestKit** you want in your project, so you're not
limited by the framework.

See the example app for real examples on how **TABTestKit** could be used to leverage writing
automation with essentially no custom code.

## Usage

There are several components to **TABTestKit**, which you can pick and choose
to use (although we think you should use all of it 😁).

### TABTestCase

`TABTestCase` is the base test case you should make **all your test cases subclass**:

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

> **NOTE:** you can query the UUID in your app at any time using `ProcessInfo.process.environment["TABTestKit.UUID"]`

`TABTestCase` automatically launches and terminates your app at the start and end
of each test. You can delay the launch or termination to provide extra setup or
teardown (like resetting a mock server), by overriding `preLaunchSetup` or `preTerminationTearDown`:

```swift
class MyTestCase: TABTestCase {

  override func preLaunchSetup(_ launch: @escaping () -> Void) {
    // Some pre-launch setup code
    launch()
  }

  func test_something() {
    // Your tests here, that will be executed after `launch()` is called above
  }

}
```

> **NOTE**: If you override `preLaunchSetup` or `preTerminationTearDown` and need
to do some asynchronous work before launching or terminating the app, you will
need to force the tests to wait until the task is complete, by using `XCTWaiter`.

### Steps and Scenarios

A huge part in making your tests human readable and they're approachable by everyone,
is to write them as [Steps](#steps) and [Scenarios](#scenarios).

Steps and Scenarios are a core part of what makes **TABTestKit** unique, and since
the framework is so flexible, you can choose to just use Steps and Scenarios without
the rest of **TABTestKit**, if you prefer.

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
`Given`/`When`/`Then` are actually just a `typealias` of a `Step` struct.

The `Step` struct has an `init` that takes **any function**, which is executed
automatically by the step at the right time.

What's really nice, is that you can **pass a function by reference**, which essentially
means you can drop the `()` for step functions that have no parameters, which makes your
code read even more like a regular sentence:

```swift
When(I: logIn)) // Instead of When(I: logIn()))
```

#### Scenarios

Scenarios wrap steps into logical groups, with a description, so that
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

Another exclusive feature of **TABTestKit** is that it makes it possible (and very
easy!) to automation iOS biometrics in the simulator.

> **NOTE:** If you're using Swift Package Manager, you'll need to `import` the `Biometrics` module to use the `Biometrics` class directly.
> Until issue [118](https://github.com/theappbusiness/TABTestKit/issues/118) is closed


#### Enabling and disabling device biometrics

```swift
Biometrics.enrolled()
Biometrics.unenrolled()
```

> **NOTE:** The term "enrolment" comes from the Simulator menu options to
enable or disable biometrics.

#### Simulating successful or failed biometric authentication

```swift
Biometrics.successfulAuthentication()
Biometrics.unsuccessfulAuthentication()
```

This works for both Face ID and Touch ID simulators, but will not work on
a physical device.

> **NOTE:** The example app has an example on how to successfully grant permissions for Face ID during a test.

### Screens & Elements

#### Screens

A `Screen` in **TABTestKit** represents a screen in your app (i.e. a UIViewController),
and is a really nice way to clearly define the structure of your screens for automation
tests.

It's a little bit like SwiftUI, where you describe what elements make your screen.

To define a screen, simply create a `struct` which conforms to `Screen`:

```swift
struct ProfileScreen: Screen {

  let trait = Header(id: "My Profile")

}
```

A `Screen` has one required property for you to implement, which is its `trait`. A
`trait` can be any [Element](#elements) that consistently, and uniquely,
identifies the screen, and is used to `await`/`waitFor` for it to appear on-screen during tests when using [contexts](#contexts).

#### Elements

`Element`s in **TABTestKit** represent all the different elements on-screen, like `View`s,
`Header`s, `Slider`s, `Alert`s, and so on.

Unlike XCTest where all `XCUIElement` objects can be tapped, scrolled and typed into,
an `Element` in **TABTestKit** declares whether it is scrollable (i.e. `ScrollView`,
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
// If using Swift 5.4 or below
let profileScreen = ProfileScreen()
profileScreen.await() // Makes sure the screen is visible before going any further by waiting for its trait
profileScreen.logOutButton.tap() // You can't call tap on an element that isn't `Tappable`, but `Button` is!
```

```swift
// If using Swift 5.5
let profileScreen = ProfileScreen()
profileScreen.waitFor() // Makes sure the screen is visible before going any further by waiting for its trait
profileScreen.logOutButton.tap() // You can't call tap on an element that isn't `Tappable`, but `Button` is!
```

All elements conform to the [`Element`](#element) protocol, which ensures that every element
has a parent element (defaults to the `App`), underlying `type`, `index` (defaults to `0`),
and has an optional ID.

**TABTestKit** uses this information to automatically query XCTest for the right `XCUIElement`
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

**TABTestKit** makes it much harder to reference the wrong button, because you use the `Alert`
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

**TABTestKit** automatically builds the `XCUIElementQuery` under the hood for you
(although you [can do it yourself](#creating-your-own-elements) if you want),
so all you have to do is describe your UI.

Using `Element`s and other protocols like [Tappable](#tappable) has even more
benefits when using [contexts](#contexts) that you can read about in
the [`InteractionContext`](#interactioncontext) documentation.

#### Creating your own Elements

**TABTestKit** comes with a lot of common elements that you can use to represent and
interact with your UI, but you can also create custom elements if none of the
predefined elements works for you.

To create your own, you can create a struct that conforms to the [`Element`](#element) protocol.

#### Extending existing Elements

By default, [`Element`s](#element) in **TABTestKit** don't support any interaction (unless you use
the `underlyingXCUIElement`).

Elements that support interaction declare that by
conforming to other protocols, like how [`Button`](#button) conforms to both `Element` and [`Tappable`](#tappable).

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

For **TABTestKit** and XCTest to be able to find your `Header`, your UIKit view
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

For **TABTestKit** and XCTest to be able to find your `Label`, your UIKit view
must have the `.staticText` trait set:

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

For **TABTestKit** and XCTest to be able to find your `Button`, your UIKit view
must have the `.button` trait set:

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
need to provide an ID to create one in **TABTestKit**, unless you need to.

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

Since `Table` conforms to [`Scrollable`](#scrollable), you can scroll it:

```swift
table.scroll(.upwards)
```

Since `Table` also conforms to [`CellContaining`](#cellcontaining), you can retrieve the number of
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

Since `CollectionView` conforms to [`Scrollable`](#scrollable), you can scroll it:

```swift
collectionView.scroll(.left)
```

Since `CollectionView` also conforms to [`CellContaining`](#cellcontaining), you can retrieve the number of
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

#### Keyboard

`Keyboard` represents the software keyboard in the app. Since there is typically
only one software keyboard on screen at any time, there is a global instance available
you can use anywhere in your tests called `keyboard`.

This is useful for a number of things, like checking if the keyboard is visible:

```swift
// If using Swift 5.4 or below
keyboard.await(.visible)
```

```swift
// If using Swift 5.5
keyboard.waitFor(.visible)
```

Checking if the current softare keyboard is the expected type:

```swift
XCTAssertEqual(keyboard.keyboardType, .regular)
XCTAssertEqual(keyboard.keyboardType, .emailAddress)
```

Or even using it to make sure you avoid the keyboard while scrolling:

```swift
let scrollView = ScrollView()
scrollView.scroll(.from(keyboard.topCoordinate, to: .top))
```

You can also use the `Keyboard` element to vend you keys which automatically
have the keyboard set as the parent:

```swift
let aKey = keyboard.key("a")
```

Since `Keyboard.Key`s conforms to `Tappable` you can tap them:

```swift
aKey.tap()
```

And you can use them with [`InteractionContext`](#interactioncontext):

```swift
Given(I: tap(aKey))
```

Additionally, you can use `Keyboard` with [`KeyboardContext`](#keyboardcontext).

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

#### Activity Sheet

`ActivitySheet` represents a `UIActivityViewController` (share sheet) in the app.

```swift
let shareSheet = ActivitySheet()
let shareSheet = ActivitySheet(parent: Safari())
```

Since `ActivitySheet` conforms to `Dismissable` you can use it directly with [`NavigationContext`](#navigationcontext):

```swift
Given(I: dismiss(shareSheet))
```

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

> **NOTE:** **TABTestKit** fails the test if the value is already the value you're trying
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

> **NOTE:** **TABTestKit** fails the test if the value is already the value you're trying
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
// If using Swift 5.4 or below
stepper.decrementButton.await(not: .enabled, timeout: 1) // Waits a max of 1 second for the button to be disabled
```

```swift
// If using Swift 5.5
stepper.decrementButton.waitFor(not: .enabled, timeout: 1) // Waits a max of 1 second for the button to be disabled
```

You can learn more about `await(not:)`/`waitFor(not:)` and other `Element` methods in the
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

#### Picker

`Picker` represents a picker in the app:

```swift
let picker = Picker(id: "MyPicker")
```

You don't interact with the picker directly, instead you interact with the wheels
inside the picker. To interact with a wheel, first ask the picker for it:

```swift
let wheel = picker.wheel(0)
```

Since a `Picker`'s `Wheel` conforms to [`ValueRepresentable`](#valuerepresentable),
you can get the string value:

```swift
XCTAssertEqual(wheel.value, "The value")
```

Since a `Picker`'s `Wheel` also conforms to [`Adjustable`](#adjustable), you can
adjust the value to another `String`:

```swift
wheel.adjust(to: "New value")
```

#### DatePicker

`DatePicker` represents a date picker in the app:

```swift
let datePicker = DatePicker(id: "MyPicker")
```

For iOS 13 and under. You don't interact with the picker directly, instead you interact with the wheels
inside the picker. To interact with a wheel, first ask the picker for it:

```swift
let wheel = datePicker.wheel(0)
```

Since a `DatePicker`'s `Wheel` conforms to [`ValueRepresentable`](#valuerepresentable),
you can get the string value:

```swift
XCTAssertEqual(wheel.value, "The value")
```

Since a `DatePicker`'s `Wheel` also conforms to [`Adjustable`](#adjustable), you can
adjust the value to another `String`:

```swift
wheel.adjust(to: "New value")
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

#### Image

`Image` represents an image or imageView in the app:

```swift
let image = Image(id: "ExampleImage")
```

Since `Image` conforms to `ValueRepresentable`, you can get the label (string) value:

```swift
XCTAssertEqual(image.value, "image of random object")
```

#### Icon

`Icon` typically represents an app icon on the Home Screen, but can represent
anything that XCUI sees as an icon.

### Predefined Screens

**TABTestKit** comes with some helpful predefined screens that you can use in your tests.

#### SystemPreferencesRootScreen

The root of the system Settings app. You can use this to navigate
to [`SystemPreferencesGeneralScreen`](#systempreferencesgeneralscreen):

```swift
systemPreferencesRootScreen.generalCell.tap()
```

> **NOTE:** You don't have to create an instance of `SystemSettingsRootScreen`
or other predefined screens, since they have already been created and are globally
available anywhere in your tests.

#### SystemPreferencesGeneralScreen

The General screen in system Settings. You can use this to
navigate to [`SystemPreferencesResetScreen`](#systempreferencesresetscreen):

```swift
systemPreferencesGeneralScreen.resetCell.tap()
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

**TABTestKit** comes with many predefined contexts, which `TABTestCase` already conforms
to, so by subclassing TABTestCase, you'll automatically have access to a wealth of
helper functions that work beautifully with [steps](#steps) & [scenarios](#scenarios), and [`Element`](#element) and other protocols

Most of the time, you won't even have to write any extra functions yourself, making it
ridiculously fast for you to get automation for your project running.

#### NavigationContext

`NavigationContext` is a predefined context that `TABTestCase` already conforms to,
which means your test cases can already use the functions in it.

`NavigationContext` provides helper functions for navigating through the app:

##### Asserting whether screens and elements are visible

Using `NavigationContext`, you can assert whether any [`Screen`](#screen)
or [`Element`](#element) is visible:

```swift
see(myScreen)
doNotSee(myScreen)

see(myScreen.button)
doNotSee(myScreen.button)
```

This reads really nicely with [steps](#steps) and [scenarios](#scenarios):

```swift
Given(I: see(myScreen))
Given(I: doNotSee(myScreen))
Given(I: see(myScreen.button))
Given(I: doNotSee(myScreen.button))
```

##### Completing and Dismissing

Using `NavigationContext`, you can complete and dismiss anything that conforms
to [`Completable`](#completable) and [`Dismissable`](#dismissable)

```swift
complete(myScreen)
dismiss(myScreen)
dismiss(myScreen.alert)

Given(I: complete(myScreen))
Given(I: dismiss(myScreen))
Given(I: dismiss(myScreen.alert))
```

You can also pass any number of `Completable` or `Dismissable` things into the function, which makes it possible for you to build up a flow through the app really
easily:

```swift
complete(nameScreen, birthDateScreen, usernameScreen)
```

##### Opening URLs and deep linking

Using `NavigationContext` in **TABTestKit** you can automate and test deep linking in your apps, as well as opening websites in Safari:

```swift
let deepLink = URL(string: "my-app://deep-link")!
open(deepLink)

let appleSite = URL(string: "https://apple.com")!
open(appleSite)

Given(I: open(deepLink))
Given(I: open(appleSite))
```

It's important to note that to do this, **TABTestKit** launches the test runner itself, and uses the test runner to open the URL.

Although **TABTestKit** will navigate to the Home Screen and find the test runner app to launch it, it is your responsibility
to decide whether to leave your app in the current state before opening the URL, or whether to terminate the app first.

This leaves you free to test how your app handles deep linking from multiple states.

You can use [`AppContext`](#appcontext) to terminate your app in a step.

#### InteractionContext

`InteractionContext` is a predefined context that `TABTestCase` already conforms to,
which means your test cases can already use the functions in it.

`InteractionContext` provides helper functions for interacting with elements in the app:

##### Tapping elements

Anything that conforms to `Tappable` can be tapped using `InteractionContext`:

```swift
tap(myScreen.button)
tap(myScreen.textField)

doubleTap(myScreen.imageView)
twoFingerTap(myScreen.someView)
longPress(myScreen.cell)

Given(I: tap(myScreen.button))
Given(I: doubleTap(myScreen.imageView))
Given(I: twoFingerTap(myScreen.someView))
Given(I: longPress(myScreen.cell))
```

##### Typing into elements

Anything that conforms to `Editable` can be typed into using `InteractionContext`:

```swift
type("Hello", into: myScreen.textField)
delete(5, charactersFrom: myScreen.textField)

Given(I: type("Hello", into: myScreen.textField))
Given(I: delete(5, charactersFrom: myScreen.textField))
```

##### Asserting the states of elements

With `InteractionContext` you can assert the states of any [`Element`](#element):

```swift
state(of: myScreen.button, is: .enabled)
state(of: myScreen.title, isNot: .hittable)

Given(the: state(of: myScreen.button, is: .enabled))
Given(the: state(of: myScreen.title, isNot: .hittable))
```

Under the hood, to avoid flakiness, **TABTestKit** will wait briefly for the expected
state, rather than asserting immediately, which is a common mistake in automation tests.

You can also pass in multiple states to assert:

```swift
state(of: myScreen.button, is: .enabled, .visible)
```

##### Scrolling elements

Anything that conforms to [`Scrollable`](#scrollable) can be scrolled
using `InteractionContext` until some element is in a particular state:

```swift
scroll(myScreen.scrollView, .downwards, until: myScreen.textField, is: .visible)

Given(I: scroll(myScreen.scrollView, .downwards, until: myScreen.textField, is: .visible))
```

You can also scroll until an element is multiple states. This is especially useful
when scrolling views that re-use their rows (like tables and collections) where
the last cell might not exist, so you can scroll until it exists, before scrolling
until it's visible:

```swift
scroll(myScreen.tableView, .downwards, until: myScreen.lastCell, is: .exists, .visible)
```

In addition to scrolling until an element is in some state (or states), you can
also scroll until an element is _not_ in some state (or states):

```swift
scroll(myScreen.tableView, .downwards, until: myScreen.firstCell, isNot: .visible)
```


##### Asserting and adjusting values

Anything element that conforms to [`ValueRepresentable`](#ValueRepresentable) can
have its value asserted using `InteractionContext`:

```swift
value(of: myScreen.header, is: "My header text")

Given(the: value(of: myScreen.header, is: "My header text"))
```

Under the hood, to avoid flakiness, **TABTestKit** will wait briefly for the expected
value, rather than asserting immediately, which is a common mistake in automation tests.

Anything that conforms to `Adjustable` can have its value adjusted using `InteractionContext`:

```swift
adjust(myScreen.toggle, to: .on)
adjust(myScreen.slider, to: 0.5)

Given(I: adjust(myScreen.toggle, to: .on))
Given(I: adjust(myScreen.slider, to: 0.5))
```

#### AppContext

`AppContext` is a predefined context that `TABTestCase` already conforms to,
which means your test cases can already use the functions in it.

`AppContext` provides helper functions for controlling the [App](#app):

##### Backgrounding and foregrounding the app

You can background and foreground the app using `AppContext`:

```swift
backgroundTheApp()
foregroundTheApp()

Given(I: backgroundTheApp) // No need for `()` in Steps
Given(I: foregroundTheApp)
```

##### Terminating and launching the app

You can terminate, background and relaunch the app using `AppContext`:

```swift
terminateTheApp()
launchTheApp(clean: true)
relaunchTheApp()

Given(I: terminateTheApp) // No need for `()` in Steps
Given(I: launchTheApp(clean: true))
Given(I: relaunchTheApp)
```

> **NOTE:** Launching the app clean requires some work on your part in your app.
See [App](#app) for more information.

#### AlertContext

`AlertContext` is a predefined context that `TABTestCase` already conforms to,
which means your test cases can already use the functions in it.

`AlertContext` provides helper functions for interacting with [`Alert`s](#alert):

```swift
tap("OK", in: myScreen.alert)

Given(I: tap("OK", in: myScreen.alert))
```
```swift
message(in: myScreen.alert, is: "Alert message")

Then(the: message(in: myScreen.alert, is: "Alert message"))
```

#### SheetContext

`SheetContext` is a predefined context that `TABTestCase` already conforms to,
which means your test cases can already use the functions in it.

`SheetContext` provides helper functions for interacting with [`Sheet`s](#sheet):

```swift
tap("Delete", in: myScreen.sheet)

Given(I: tap("Delete", in: myScreen.sheet))
```

#### KeyboardContext

`KeyboardContext` is a predefined context that `TABTestCase` already conforms to,
which means your test cases can already use the functions in it.

`KeyboardContext` provides helper functions for interacting with the `Keyboard`.:

```swift
keyboardType(is: .twitter)

Given(the: keyboardType(is: .twitter))
```

#### BiometricsContext

`BiometricsContext` is a predefined context that `TABTestCase` already conforms to,
which means your test cases can already use the functions in it.

`BiometricsContext` provides helper functions for simulating [Biometrics](#biometrics) in tests:

> **NOTE:** Biometric simulation only works in simulators, not on a real device

##### Enabling and disabling biometrics

`BiometricsContext` allows you to easily control whether device biometrics are
enabled on the simulator:

```swift
deviceBiometricsAreEnabled()
deviceBiometricsAreDisabled()

Given(deviceBiometricsAreEnabled) // No need for `()` in Steps
Given(deviceBiometricsAreDisabled)
```

##### Simulating successful and failed authentication

`BiometricsContext` allows you to easily simulate either a successful, or unsuccessful
authentication. This works for both Face ID and Touch ID:

```swift
successfullyAuthenticateBiometrics()
failToAuthenticateBiometrics()

Given(I: successfullyAuthenticateBiometrics) // No need for `()` in Steps
Given(I: failToAuthenticateBiometrics)
```

#### SystemPreferencesContext

`SystemPreferencesContext` is a predefined context that `TABTestCase` already conforms to,
which means your test cases can already use the functions in it.

`SystemPreferencesContext` provides helper functions for interacting with System Preferences:

##### Opening and terminating System Preferences

```swift
openSystemPreferences()
terminateSystemPreferences()

Given(I: openSystemPreferences)  // No need for `()` in Steps
Given(I: terminateSystemPreferences)
```

#### TabBarContext

`TabBarContext` is a predefined context that `TABTestCase` already conforms to,
which means your test cases can already use the functions in it.

`TabBatContext` provides helper functions for counting tabs in TabBar.

```swift
func numberOfTabs(in tabBar: TabBar, is count: Int)

And(the: numberOfTabs(in: tabBarScreen.tabBar, is: 4))
```

##### Resetting all privacy prompts

`SystemPreferencesContext` provides a way to reset all privacy prompts in a
simulator without having to delete and re-install the app:

```swift
resetAllPrivacyPrompts()

Given(I: resetAllPrivacyPrompts)  // No need for `()` in Steps
```

As an example, you could call `resetAllPrivacyPrompts()` as part of your [`preLaunchSetup`](#tabtestcase).

### Protocols

**TABTestKit** is driven under the hood by protocols. Unless you're creating your own
elements, the likelihood is you will only need to implement a few yourself, like
[`Screen`](#screen), [`Completable`](#completable) and [`Dismissable`](#dismissable).

#### Screen

You use `Screen`s in your app to describe your UI in a particular screen.

Each `Screen` must have a trait that identifies it, and that trait can be anything
that conforms to `Element`:

```swift
struct MyScreen: Screen {

  let trait = View(id: "MyViewControllerView")

}
```

Typically, your screen's trait would be a `View` or `Header`, but it can be anything
that consistently identifies your screen.

The `trait` is used by **TABTestKit** in [`NavigationContext`](#navigationcontext) to assert
whether your screen is or isn't on-screen currently.

#### ScrollableScreen

`ScrollableScreen` is similar to [`Screen`](#screen), but to conform to it you
must set a `trait` that is an [`Element`](#element) that also conforms to [`Scrollable`](#scrollable):

```swift
struct MyScrollableScreen: ScrollableScreen {

  let trait = ScrollView() // Since ScrollView conforms to `Scrollable` it can be used as the trait.

}
```

By conforming to `ScrollableScreen`, your screen will automatically be `Scrollable`,
and you can use it to scroll directly or pass it into [`InteractionContext`](#interactioncontext) functions that take a `Scrollable` argument:

```swift

collectionViewScreen.scroll(.downwards)

Given(I: scroll(myScrollableScreen, .downwards, until: myScrollableScreen.textField, is: .visible))
```

#### Completable

Generally, you would make your screens conform to `Completable`:

```swift
extension MyScreen: Completable {

  func complete() {
    nextButton.tap()
  }

}
```

The `complete` function should know how to complete itself, in the case of a screen
that would be the primary happy path flow through it.

You can make anything conform to `Completable` and use it with [`NavigationContext`](#navigationcontext)

#### Dismissable

Generally, you would make your screens conform to `Dismissable`:

```swift
extension MyScreen: Dismissable {

  func dismiss() {
    backButton.tap()
  }

}
```

The `dismiss` function should know how to dismiss itself, in the case of a screen
that would generally be tapping the back, done or close button.

You can make anything conform to `Dismissable` and use it with [`NavigationContext`](#navigationcontext),
just like [`Alert`](#alert).

#### Element

`Element` is the backbone of **TABTestKit**, and essentially replaces `XCUIElement`
(more technically, `Element` wraps `XCUIElement`).

Every `Element` must provide:

- An optional `id`
- The element's `parent` element (generally the app)
- The `index` of the element (in the case of multiple matches or cells)
- The underlying `type` of the element (i.e. staticText, alert etc)
- The `label` of the element (i.e the accessibilityLabel of your view)
- The `underlyingXCUIElement` that it represents.

If you're creating your own `Element` type, **TABTestKit** figures most of this out
for you, so at minimum you only have to provide the ID and type:

```swift
struct MyElement: Element {

  let id: String? = "MyElementID"
  let type: XCUIElement.ElementType = .other

}
```

`Element` has defaults for the other properties that mean the `underlyingXCUIElement`
can be automatically figured out. You can override any of these defaults as you need.

You shouldn't often need to create your own elements, but if you do and you think
people would benefit from it, please consider contributing and creating a PR!

##### Element states

The `Element` protocol has some functions for asserting and determining states,
that anything conforming to `Element` will have access to.

You can wait for the element to be (or not be) in a particular state:

```swift
// If using Swift 5.4 or below
button.await(.visible, .enabled, timeout: 10) // You can provide more than one state to wait for :)
button.await(not: .enabled, timeout: 10)
```

```swift
// If using Swift 5.5
button.waitFor(.visible, .enabled, timeout: 10) // You can provide more than one state to wait for :)
button.waitFor(not: .enabled, timeout: 10)
```

If the element doesn't become the expected state within the timeout, the test will fail.

If you're not using **TABTestKit** [contexts](#contexts), it is extremely advisable to
use the functions provided by `Element`, rather than asserting values immediately.

Not waiting for values and states to be true is one of the highest contributors to flaky and
frustrating automation tests.

#### Tappable

Anything that conforms to `Tappable` (like [`Button`](#button)), is declaring it
can be tapped, this includes single, double and two finger taps, as well as long pressing.

`Tappable` works really well with [`InteractionContext`](#interactioncontext).

Additionally, any [`Element`](#element) that conforms to `Tappable` doesn't have
to do any extra work, default implementations will be provided automatically.

#### Editable

Anything that conforms to `Editable` (like [`TextField`](#textfield)), is declaring
it can have text entered into/removed from it.

`Editable` works really well with [`InteractionContext`](#interactioncontext).

Additionally, any [`Element`](#element) that conforms to `Editable` doesn't have to
do any extra work, default implementations will be provided automatically.

#### Scrollable

Anything that conforms to `Scrollable`, (like [`ScrollView`](#scrollview)), is
declaring it can be scrolled.

`Scrollable` works really well with [`InteractionContext`](#interactioncontext),
you can also make your screens conform to `Scrollable` so they can be scrolled
directly:

```swift
extension MyScreen: Scrollable {

  func scroll(_ direction: ElementAttributes.Direction) {
    scrollView.scroll(direction)
  }

}
```

Additionally, any [`Element`](#element) that conforms to `Scrollable` doesn't
have to do any extra work, default implementations will be provided automatically.

#### ValueRepresentable

Anything that conforms to `ValueRepresentable`, (like [`Label`](#label)) is
declaring that is has some sort of value.

The conforming type decides what the type of value it is when conforming to
`ValueRepresentable`. In the case of [`Header`](#header), it's a `String`, but
a [`Slider`](#slider)'s value is a `CGFloat`.

Regardless of what the value is, it can be used with [`InteractionContext`] to
assert the value of the `ValueRepresentable` thing.

#### Adjustable

Anything that conforms to `Adjustable`, (like [`Slider`](#slider)) is
declaring that it can be adjusted or have its value changed.

The conforming type decides what the type of value it is when conforming to
`Adjustable`. In the case of [`Slider`](#slider), it's a `CGFLoat`, but
a [`Switch`](#switch)'s value is a `Switch.State` (either `.on` or `.off`).

Regardless of what the value is, it can be used with [`InteractionContext`] to
adjust/change the value.

#### CellContaining

Anything that conforms to `CellContaining`, (like [`Table`](#table)) is declaring
that it can provide the number of cells it contains, and can also vend a [`Cell`](#cell).

> **NOTE:** It's important to understand that due to the way tables and collection
views work to re-use views means that XCUI won't necessarily have the same count
of cells compared to the total number of rows or items in the table or collection.
Thus, finding the "last" cell by index isn't reliable, and instead you should use
an identifier in the cell to identify it as the last cell, i.e. using the indexPath.

Additionally, any [`Element`](#element) that conforms to `CellContaining` doesn't have to
do any extra work, default implementations will be provided automatically.

### Apps

**TABTestKit** comes with some predefined apps, all of which inherit from `BaseApp` which
you are encouraged to subclass if you need to make any more apps.

### BaseApp

This is the base app class that all the predefined apps inherit from.

Inheriting from `BaseApp` means that you get enhanced waits for the app to be in
the correct state before continuing, and also means you get an extra function to
background the app, that Apple doesn't provide with `XCUIApplication`.

Additionally, `BaseApp` (and anything that inherits from it) conforms to the [`Element`](#element)
protocol, which means any app (including [`SystemPreferences`](#systempreferences))
can be set as the parent element for elements.

### App

`App` inherits from [`BaseApp`](#baseapp) and is what you should use to reference
your app in tests, and to do so you must use the shared instance:

```swift
App.shared
```

You can use `App` as the parent for any [`Element`](#element), to ensure that you're matching
elements within your app.

### SystemPreferences

`SystemPreferences` inherits from [`BaseApp`](#baseapp) and represents the system
Preferences app.

You can use `SystemPreferences` as the parent for any [`Element`](#element), to allow you to
interact with elements within the system Preferences (yes really!).

### Safari

`Safari` inherits from [`BaseApp`](#baseapp) and represents the Safari app.

You can use `Safari` as the parent for any [`Element`](#element), to allow you to
interact with elements within Safari.

### Springboard

`Springboard` inherits from [`BaseApp`](#baseapp) and is a very special app,
because it essentially represents the OS.

You can use `Springboard` as the parent for any [`Element`](#element),
including [`Alert`](#alert), which means you can interact with any alert which is displayed by the OS over your
app, like Face ID permission prompts.

## Requirements

**TABTestKit** has **no dependencies** and supports **iOS 10** and newer. 🎉

## Installation


### Swift Package Manager

You can add **TABTestKit** as a remote Swift Package dependency in Xcode 11 or newer.

Due to the way SPM requires mixed-langage packages to be built, if you want to use the
`Biometrics` class, you'll need to `import Biometrics` until we expose it in Swift (issue [#118](https://github.com/theappbusiness/TABTestKit/issues/118)).

You don't need to `import Biometrics` if you're just using the helper functions in `BiometricsContext`.

### Cocoapods

#### Latest

To use the latest version of **TABTestKit** just add this to your `Podfile` and
run `pod update` or `pod install` in Terminal:

```ruby
pod 'TABTestKit'
```

#### Development

To use the version under development you can target the `develop` branch specifically:

```ruby
pod 'TABTestKit', :git => 'https://github.com/theappbusiness/TABTestKit.git', :branch => 'develop'
```

#### Subspecs

There are a number of Cocoapod subspecs available. This means you can get a
subset of `**TABTestKit**`'s functionality if, for example, you only want to
use the biometrics automation capabilities of the framework.

##### Biometrics Subspec

Use this subspec to just install the biometric automation capabilities of **TABTestKit**:

```ruby
pod 'TABTestKit/Biometrics'
```

##### BDD Subspec

Use this subspec to just install the BDD steps and scenarios capabilities of **TABTestKit**:

```ruby
pod 'TABTestKit/BDD'
```

##### XCUIExtensions Subspec

Use this subspec to just install the XCTest/XCUI extensions **TABTestKit** uses:

```ruby
pod 'TABTestKit/XCUIExtensions'
```

### Carthage

#### Latest

To use the latest version of **TABTestKit** just add this to your `Cartfile.private` and run `carthage bootstrap` or `carthage update` in Terminal

```
github "TABTestKit"
```

If this is your first time using Carthage in the project, you'll need to go through some additional steps as explained [over at Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

> NOTE: At this time, Carthage does not provide a way to build only specific repository submodules. `TABTestKit`, `BDD` and `Biometrics` will be combined into one single framework.

#### Development

To use the version under development you can target the `develop` branch specifically:

```
github "TABTestKit" "develop"
```

## Contributing

Guidelines for contributing can be found [here](CONTRIBUTING.md).

## Authors

Neil Horton, neil.horton@kinandcarta.com, https://github.com/neil3079  
Zachary Borrelli, zac.borrelli@kinandcarta.com, https://github.com/zacoid55  
Kane Cheshire, kane.cheshire@kinandcarta.com, https://github.com/kanecheshire  
Suyash Srijan, suyash.srijan@kinandcarta.com, https://github.com/theblixguy

## License

**TABTestKit** is available under the MIT license. See the LICENSE file for more info.
