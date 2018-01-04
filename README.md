![The App Business](Assets/logo.png)

# TABTestKit

[![CI Status](https://travis-ci.org/theappbusiness/TABTestKit.svg?branch=develop)](https://travis-ci.org/theappbusiness/TABTestKit)
[![Version](https://img.shields.io/cocoapods/v/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)
[![License](https://img.shields.io/cocoapods/l/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)
[![Platform](https://img.shields.io/cocoapods/p/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)

Framework for extending the structuring of XCUI tests in a BDD style using the POM, steps and gherkin styled feature files found in the pod `XCTest-Gherkin`. Also a collection of functions to make XCUI easier to use and read.

## Requirements
XCTest-Gherkin (Read more on the setting up of Feature and Step files here: [XCTest-Gherkin Github](https://github.com/net-a-porter-mobile/XCTest-Gherkin))

## Installation
TABTestKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TABTestKit'
```

## Configure your iOS project
To start, make sure all of the feature and page files that are created, inherit from `BaseFeature` and `BasePage` repsectively. `BaseFeature` contains all of the setup, launch and tear down for the for app and each test case that is run. `BasePage` contains access to the trait element with allows the `await()` function to be called, along with a built-in Back Button interaction.

```swift
class ExampleFeature: BaseFeature {
  func test_ExampleFeature() {
    Given("I have opened the application")
  }
}
```

```swift
class ExampleSteps: StepDefiner {
  let examplePage = ExamplePage()
  
  override func defineSteps() {
    step("I have opened the application") {
      self.examplePage.await()
    }
  }
}
```

For the basics around writing Steps, please see XCTest-Gherkin's [documentation](https://github.com/net-a-porter-mobile/XCTest-Gherkin#step-definitions).

When configuring a Step file, you will have to provide an instance of each of the pages you want to reference. You can either do this for every step file or create a `BaseSteps` file to compile a list of page instances and inherit from that on the other step files, getting rid of the duplication.

```swift
final class ExamplePage: BasePage {
  let app: XCUIApplication
  let trait: XCUIElement
  let searchField: XCUIElement

  override init() {
    app = App.shared.current()
    searchField = app.textFields["Search Field"]
    trait = app.staticTexts["Hello World!"]
  }
}
```

You will recognise this as setting up page objects for ineracting with e.g. a button, field, label etc. The one important one to note here is `app`. This must be present in all pages as it is the link to the singleton instance of the app under test.

See below for a more indepth usage guide of `BasePage` and `BaseFeature`

## Usage
To run the UI automation tests, switch to the `TABTestKit_ExampleUITests` and use `CMD + U`.

### BasePage
`trait`: This is a page element that can be defined once a page has inherited from `BasePage` which will allow you to call `.await()` on that page.  
`await`: Uses the given `trait` element for a page and calls `waitForElementToAppear()` on it. Using a unique element to that page is the recommended selection for a trait.  
`tapBackButton`: Use a generic identifier matcher to find the native Back button and tap it. Note: This is done by the specific "Back" string - will need to be overriden for a custom back button.

### BaseFeature
`setUp`: Starts the XCTestCase instance with, defaulting `continueAfterFailure` to `false` and launches the App using `launchApp()`.  
`launchApp`: Calls `launchWithOptions()` from the App singleton to launch the app at the beginning of each XCTestCase.  
`tearDown`: Calls `terminate()`  from the App singleton to terminate the app after each XCTestCase.

### Global functions
`waitForElementToAppear`: Takes an element and waits for a default (but overridable) amount of time and checks over that time period whether that element exists and is hittable.  
`tapWhenElementAppears`: Runs  `waitForElementToAppear` and adds a `.tap()` call onto the element.  
`waitForElementToDisappear`: Takes an element and waits a for a default (overridable) amount of time and checks over that time period whether that element doesn't exist and isn't hittable.  
`tapCoordinate`: Takes an x and y value and taps it.

### XCUIElement+ScrollTo
(This is an extension of XCUIElement)  
`scollToLastCell`: Finds the last cell on the page and uses `scroll` to get to it.  
`scroll`: Scrolls to a given element, the default is to scroll down but this is overridable using a `bool` argument flag.

## Contributing
Guidelines for contributing can be found [here](CONTRIBUTING.md).

## Author
Neil Horton, neil@theappbusiness.com, https://github.com/neil3079  
Zachary Borrelli, zac@theappbusiness.com, https://github.com/zacoid55  

## Credits
[XCTest-Gherkin](https://github.com/net-a-porter-mobile/XCTest-Gherkin) - Sam Dean, sam.dean@net-a-porter.com

## License
TABTestKit is available under the MIT license. See the LICENSE file for more info.
