//
//  ViewController.swift
//  TABTestKit
//
//  Created by zacoid55 on 09/14/2017.
//  Copyright (c) 2017 zacoid55. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var helloWorldLabel: UILabel!
  
    override func viewDidLoad() {
      helloWorldLabel.text = "Hello world!"
      helloWorldLabel.accessibilityIdentifier = "Hello World Label"
      super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}

