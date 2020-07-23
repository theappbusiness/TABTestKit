//
//  CollectionViewScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/10/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import TABTestKit

var collectionViewScreen = CollectionViewScreen()

struct CollectionViewScreen: ScrollableScreen {
  
  let trait = CollectionView()
  lazy var firstCell = trait.cell(matchingID: "CollectionCell 0")
  lazy var lastCell = trait.cell(matchingID: "CollectionCell 49")
  
}
