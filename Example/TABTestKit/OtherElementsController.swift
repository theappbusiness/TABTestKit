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
  @IBOutlet private var secureTextField: UITextField!
  @IBOutlet private var slider: UISlider!
  @IBOutlet private var toggle: UISwitch!
  @IBOutlet private var stepper: UIStepper!
  @IBOutlet private var pageControl: UIPageControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    segmentedControlContainerView.accessibilityIdentifier = "ExampleSegmentedControl"
    textField.accessibilityIdentifier = "ExampleTextField"
    secureTextField.accessibilityIdentifier = "ExampleSecureTextField"
    slider.accessibilityIdentifier = "ExampleSlider"
    toggle.accessibilityIdentifier = "ExampleSwitch"
    stepper.accessibilityIdentifier = "ExampleStepper"
    pageControl.accessibilityIdentifier = "ExamplePageControl"
  }
  
}
