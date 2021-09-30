//
//  OtherElementsController.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/09/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import UIKit

// TODO: Text view

final class OtherElementsController: UIViewController {
  
  @IBOutlet private var scrollView: UIScrollView!
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
  @IBOutlet private var imageView: UIImageView!
  @IBOutlet private var picker: UIPickerView!
  @IBOutlet private var timePicker: UIDatePicker!
  @IBOutlet private var datePicker: UIDatePicker!
  @IBOutlet private var dateTimePicker: UIDatePicker!
  @IBOutlet private var countDownTimerPicker: UIDatePicker!

  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.accessibilityIdentifier = "MyScrollView"
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
    imageView.image = UIImage(named: "ottoman")
    imageView.accessibilityLabel = "Ottoman"
    imageView.accessibilityIdentifier = "ExampleImage"
    picker.accessibilityIdentifier = "ExamplePicker"
    picker.dataSource = self
    picker.delegate = self
    timePicker.accessibilityIdentifier = "ExampleTimePicker"
    datePicker.accessibilityIdentifier = "ExampleDatePicker"
    dateTimePicker.accessibilityIdentifier = "ExampleDateTimePicker"
    countDownTimerPicker.accessibilityIdentifier = "ExampleCountDownTimerPicker"
  }
  
  @IBAction private func buttonTapped() {
    let sheet = UIActivityViewController(activityItems: ["hello"], applicationActivities: nil)
    present(sheet, animated: true)
  }
  
    @IBAction func buttonAlertTapped() {
        let alertController = UIAlertController(title: "Alert title", message: "Alert Message", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: { _ in
            alertController.dismiss(animated: true)
        })
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
}

extension OtherElementsController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

extension OtherElementsController: UIPickerViewDataSource & UIPickerViewDelegate {
  
  var values: [String] { return ["Hello", "World"] }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int { return 2 }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return values.count }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return values[row] }
  
}
