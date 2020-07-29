//
//  CollectionViewScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 11/10/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import TABTestKit
import XCTest

var collectionViewScreen = CollectionViewScreen()

struct CollectionViewScreen: ScrollableScreen {
    
    let trait = CollectionView()
    let header = Header(id: "Collection")
    lazy var firstCell = trait.cell(matchingID: "CollectionCell 0")
    lazy var lastCell = trait.cell(matchingID: "CollectionCell 49")
    
}

extension CollectionViewScreen: Refreshable, InteractionContext {
    
    func refresh() {
        scroll(trait, .upwards, until: trait.cell(matchingID: "CollectionCell 0"), is: .visible)
        // Pull the collection view down to refresh
        trait.scroll(.upwards)
    }
}
