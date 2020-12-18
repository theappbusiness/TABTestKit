//
//  YellowPageScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Anna Piktas on 17/12/2020.
//  Copyright © 2020 The App Business LTD. All rights reserved.
//

import Foundation
import TABTestKit

let yellowPageScreen = YellowPageScreen()

struct YellowPageScreen: Screen {
    
    let trait = View(id: "YellowPage")
    let navBar = NavBar()
    let backButton = Button(id: "Row 14 section 1")
}
