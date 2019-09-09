//
//  ExampleScreen.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import TABTestKit

struct ExampleScreen: Screen {
	
  let trait = Label(id: "Hello world!")
  let authenticateButton = Button(id: "authenticateButton")
  let authenticateLabel = Label(id: "biometricStatusLabel")
	
}

let exampleScreen = ExampleScreen()


struct AScreen: Screen {
  
  let trait = ViewController(id: "")
  let collectionView = CollectionView(id: "")
  var firstCell: CollectionView.Cell {
    return .init(id: "cell", index: 0, collectionView: collectionView)
  }
  var lastCell: CollectionView.Cell {
    let lastIndex = collectionView.numberOfCells(matchingID: "cell") - 1
    return .init(id: "cell", index: lastIndex, collectionView: collectionView)
  }
  
}
