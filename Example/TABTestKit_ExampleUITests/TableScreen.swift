//
//  TableScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 The App Business LTD. All rights reserved.
//

import TABTestKit

let tableScreen = TableScreen()

struct TableScreen: Screen, TableDisplaying, Scrollable {
  
  let trait = Header(id: "Table")
  
}
