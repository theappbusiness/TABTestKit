![The App Business](Assets/logo.png)

# TABTestKit

[![Build Status](https://travis-ci.org/theappbusiness/TABTestKit.svg?branch=master)](https://travis-ci.org/theappbusiness/TABTestKit)
[![Version](https://img.shields.io/cocoapods/v/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)
[![License](https://img.shields.io/cocoapods/l/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)
[![Platform](https://img.shields.io/cocoapods/p/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)

Framework for improving the structuring of XCUI tests in a BDD style using the POM, steps and gherkin styled feature files. Also a collection of functions to make XCUI easier to use and read.

## Requirements
TABTestKit has no dependencies and supports iOS 10 and newer.

## Installation
TABTestKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TABTestKit'
```

## Getting started
There are three core concepts in TABTestKit:

- Screens: these represent the screens in your app
- Features: these represent the features the screens have that you want to test
- Steps: these represent the steps that you need to carry out to test the features

To create a screen, create a class that conforms to `UITestScreen`:

```swift
final class ExampleScreen: UITestScreen {

  let trait: XCUIElement // Required property to conform to UITestScreen, used for awaiting screens

  init() {
    trait = App.shared.otherElements["Screen title here"]
  }

}
```

Once you've created a screen, you can use it in features by creating a series of steps:

```swift
class ExampleFeature: TestBase {

  let exampleScreen = ExampleScreen()

  func test_exampleTest() {
    Given(I: backgroundTheApp) // backgroundTheApp is a real function! See below.
    When(I: foregroundTheApp)
    Then(I: seeTheExampleScreen)
  }

}

private extension ExampleFeature {

  func backgroundTheApp() {
    XCUIDevice.shared.press(.home)
  }

  func foregroundTheApp() {
    App.shared.activate()
  }

  func seeTheExampleScreen() {
    exampleScreen.await()
  }

}
```
When the `test_exampleTest` function runs as part of a test run, each step gets called automatically, and since they're real functions you get code completion, syntax highlighting, and help from the compiler.

See below for more in-depth discussion around steps and scenarios.

### UITestScreen
- `trait`: This is a screen element that must be defined once a page has conformed to `UITestScreen` which will allow you to call `.await()` on that screen.  
- `await`: Uses the given `trait` element for a screen and calls `waitForElementToAppear()` on it. Using a unique element to that screen is the recommended selection for a trait.  
- `waitForElementToAppear`: Takes an element and waits for a default (but overridable) amount of time and checks over that time period whether that element exists and is hittable.  
- `tapWhenElementAppears`: Runs  `waitForElementToAppear` and adds a `.tap()` call onto the element.  
- `waitForElementToDisappear`: Takes an element and waits a for a default (overridable) amount of time and checks over that time period whether that element doesn't exist and isn't hittable.  
- `tapCoordinate`: Takes an x and y value and taps it.

### TestBase
- `setUp`: Starts the XCTestCase instance with, defaulting `continueAfterFailure` to `false` and launches the App using `launchApp()`.  
- `launchApp`: Calls `launchWithOptions()` from the App singleton to launch the app at the beginning of each XCTestCase.  
- `tearDown`: Calls `terminate()`  from the App singleton to terminate the app after each XCTestCase.

### Steps and Scenarios
Within test functions you define different steps. Steps can be one of the following:
- `Given`
- `When`
- `Then`
- `And`

Steps are all typealiases of a struct called `Step`, which is initialised with a handler or function to call when the test runs.
Thanks to Swift treating functions as reference types, you can pass functions directly into steps like this:

```swift
func doSomething() {}
Given(I: doSomething)
```

Notice how it's possible to omit the `()` from the function. That's because you're not actually calling the function here, you're just passing it in to be called by the step when it's created during the test run.

Steps have three different initialisers, allowing your test code to be human readable and expressive:

```swift
Given(I: doSomething)
When(the: backEndIsErroring)
Then(nothingHappens)
```

To make your code even more readable, you can go one step further and group steps in scenarios:
```swift
Scenario("Doing something when the back end is erroring") {
  Given(I: doSomething)
  When(the: backEndIsErroring)
  Then(nothingHappens)
}
```

Grouping steps in scenarios not only make your tests more readable, it also improves the Xcode test report logs as well as allowing you to run multiple scenarios in one test function, reducing test run time, without losing clarity:

```swift
func test_happyPath() {
  Scenario("Launching the app") {
    Given(I: launchTheApp)
    When(the: backEndIsWorking)
    Then(I: seeTheLoginScreen)
  }

  Scenario("Logging in") {
    Given(I: seeTheLoginScreen)
    When(I: logIn)
    Then(I: seeTheSettingsScreen)
  }
}

```

Finally, you can pass functions into steps that take arguments, meaning you can do stuff like this:
```swift
enum Screen {
  case login
  case settings
}
func see(theScreen screen: Screen) {
  switch screen {
    case .login: loginScreen.await()
    case .settings: settingsScreen.await()
  }
}
Given(I: see(theScreen: .login))
When(I: logIn)
Then(I: see(theScreen: .settings))
```

### XCUIElement Extensions
- `scollToLastCell`: Finds the last cell on the page and uses `scroll` to get to it.  
- `scroll`: Scrolls to a given element, the default is to scroll down but this is overridable using a `bool` argument flag.
- `visible`: Whether the element is visible.

## Usage
To run the UI automation tests, switch to the UI test scheme in your project and press `CMD + U`.

## Contributing
Guidelines for contributing can be found [here](CONTRIBUTING.md).

## Author
Neil Horton, neil@theappbusiness.com, https://github.com/neil3079  
Zachary Borrelli, zac@theappbusiness.com, https://github.com/zacoid55
Kane Cheshire, kane.cheshire@theappbusiness.com, https://github.com/kanecheshire

## License
TABTestKit is available under the MIT license. See the LICENSE file for more info.
