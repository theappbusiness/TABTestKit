//
//  OtherElementsController.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/09/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import UIKit

// TODO: Text view

final class OtherElementsController: UIViewController {
  
  @IBOutlet private var label: UILabel!
  @IBOutlet private var button: UIButton!
  @IBOutlet private var segmentedControlContainerView: UIView!
  @IBOutlet private var segmentedControl: UISegmentedControl!
  @IBOutlet private var textField: UITextField!
  @IBOutlet private var numberPadTextField: UITextField!
  @IBOutlet private var decimalPadTextField: UITextField!
  @IBOutlet private var emailAddressTextField: UITextField!
  @IBOutlet private var numbersAndPunctuationTextField: UITextField!
  @IBOutlet private var phonePadTextField: UITextField!
  @IBOutlet private var twitterTextField: UITextField!
  @IBOutlet private var urlTextField: UITextField!
  @IBOutlet private var webSearchTextField: UITextField!
  @IBOutlet private var secureTextField: UITextField!
  @IBOutlet private var slider: UISlider!
  @IBOutlet private var toggle: UISwitch!
  @IBOutlet private var stepper: UIStepper!
  @IBOutlet private var pageControl: UIPageControl!
  @IBOutlet private var picker: UIPickerView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    segmentedControlContainerView.accessibilityIdentifier = "ExampleSegmentedControl"
    textField.accessibilityIdentifier = "ExampleTextField"
    numberPadTextField.accessibilityIdentifier = "NumberPadTextField"
    decimalPadTextField.accessibilityIdentifier = "DecimalPadTextField"
    emailAddressTextField.accessibilityIdentifier = "EmailAddressTextField"
    numbersAndPunctuationTextField.accessibilityIdentifier = "NumbersAndPunctuationTextField"
    phonePadTextField.accessibilityIdentifier = "PhonePadTextField"
    twitterTextField.accessibilityIdentifier = "TwitterTextField"
    urlTextField.accessibilityIdentifier = "URLTextField"
    webSearchTextField.accessibilityIdentifier = "WebSearchTextField"
    secureTextField.accessibilityIdentifier = "ExampleSecureTextField"
    slider.accessibilityIdentifier = "ExampleSlider"
    toggle.accessibilityIdentifier = "ExampleSwitch"
    stepper.accessibilityIdentifier = "ExampleStepper"
    pageControl.accessibilityIdentifier = "ExamplePageControl"
    picker.accessibilityIdentifier = "ExamplePicker"
    picker.dataSource = self
    picker.delegate = self
  }
  
}

extension OtherElementsController: UIPickerViewDataSource & UIPickerViewDelegate {
  
  var values: [String] { return ["Hello", "World"] }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int { return 2 }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return values.count }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return values[row] }
  
}
