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

## Usage
To run the UI automation tests, switch to the UI test scheme in your project and press `CMD + U`.

### UITestScreen
- `trait`: This is a page element that can be defined once a page has inherited from `BasePage` which will allow you to call `.await()` on that page.  
- `await`: Uses the given `trait` element for a page and calls `waitForElementToAppear()` on it. Using a unique element to that page is the recommended selection for a trait.  
- `waitForElementToAppear`: Takes an element and waits for a default (but overridable) amount of time and checks over that time period whether that element exists and is hittable.  
- `tapWhenElementAppears`: Runs  `waitForElementToAppear` and adds a `.tap()` call onto the element.  
- `waitForElementToDisappear`: Takes an element and waits a for a default (overridable) amount of time and checks over that time period whether that element doesn't exist and isn't hittable.  
- `tapCoordinate`: Takes an x and y value and taps it.

### TestBase
`setUp`: Starts the XCTestCase instance with, defaulting `continueAfterFailure` to `false` and launches the App using `launchApp()`.  
`launchApp`: Calls `launchWithOptions()` from the App singleton to launch the app at the beginning of each XCTestCase.  
`tearDown`: Calls `terminate()`  from the App singleton to terminate the app after each XCTestCase.

### XCUIElement+ScrollTo
(This is an extension of XCUIElement)  
`scollToLastCell`: Finds the last cell on the page and uses `scroll` to get to it.  
`scroll`: Scrolls to a given element, the default is to scroll down but this is overridable using a `bool` argument flag.

## Contributing
Guidelines for contributing can be found [here](CONTRIBUTING.md).

## Author
Neil Horton, neil@theappbusiness.com, https://github.com/neil3079  
Zachary Borrelli, zac@theappbusiness.com, https://github.com/zacoid55  

## License
TABTestKit is available under the MIT license. See the LICENSE file for more info.
