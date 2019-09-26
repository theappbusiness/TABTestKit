//
//  TableSelectionScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/09/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import TABTestKit

let tableSelectionScreen = TableSelectionScreen()

struct TableSelectionScreen: Screen {
  
  let trait = View(id: "TableSelection")
  let navBar = NavBar()
  let backButton = Button(id: "Table")
  
}
