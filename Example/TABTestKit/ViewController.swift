//
//  ViewController.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 09/14/2017.
//  Copyright (c) 2017 Zachary Borrelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var helloWorldLabel: UILabel!
  
    override func viewDidLoad() {
      helloWorldLabel.text = "Hello world!"
      helloWorldLabel.accessibilityIdentifier = "Hello World Label"
    }
}

