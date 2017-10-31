# TABTestKit

[![CI Status](http://img.shields.io/travis/zacoid55/TABTestKit.svg?style=flat)](https://travis-ci.org/zacoid55/TABTestKit)
[![Version](https://img.shields.io/cocoapods/v/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)
[![License](https://img.shields.io/cocoapods/l/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)
[![Platform](https://img.shields.io/cocoapods/p/TABTestKit.svg?style=flat)](http://cocoapods.org/pods/TABTestKit)

Framework for structuring BDD style UI tests using POM, steps and gherkin styled feature files. Also a collection of functions to make XCUI easier to use and read.

## Requirements
XCTest-Gherkin

## Installation

TABTestKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TABTestKit'
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To run the UI automation test, switch to the `TABTestKit_ExampleUITests` and use `CMD + U`.

To start, make sure all of the feature and page files that are created, inherit from `BaseFeature` and `BasePage` repsectively. `BaseFeature` contains all of the setup, launch and tear down for the for app and each test case that is run. `BasePage` contains access to the trait element with allows the `await()` function to be called, along with a built-in Back Button interaction.

###BasePage
`trait`: This is a page element that can be defined once a page has inherited from `BasePage` which will allow you to call `.await()` on that page.
`await`: Uses the given `trait` element for a page and calls `waitForElementToAppear()` on it. Using a unique element to that page is the recommended selection for a trait.
`tapBackButton`: Use a generic identifier matcher to find the native Back button and tap it. Note: This is done by the specific "Back" string - will need to be overriden for a custom back button.

### Global functions
`waitForElementToAppear`: Takes an element and waits for a default (but overridable) amount of time and checks over that time period whether that element exists and is hittable.
`tapWhenElementAppears`: Runs  `waitForElementToAppear` and adds a `.tap()` call onto the element.
`waitForElementToDisappear`: Takes an element and waits a for a default (overridable) amount of time and checks over that time period whether that element doesn't exist and isn't hittable. 
`tapCoordinate`: Takes an x and y value and taps it

### XCUIElement+ScrollTo
(This is an extension of XCUIElement)
`scollToLastCell`: Finds the last cell on the page and uses `scroll` to get to it
`scroll`: Scrolls to a given element, the default is to scroll down but this is overridable using a `bool` argument flag

## Author

Zachary Borrelli, zac@theappbusiness.com, https://github.com/zacoid55

## License

TABTestKit is available under the MIT license. See the LICENSE file for more info.
