//
//  TabBarScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 12/09/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import TABTestKit

let tabBarScreen = TabBarScreen()

struct TabBarScreen: Screen {
    
    var trait: TabBar { return tabBar }
    let tabBar = TabBar()
    var tableTabBarButton: Button {
        return tabBar.button(withID: "Table")
    }
    var collectionTabBarButton: Button {
        return tabBar.button(withID: "Collection")
    }
    var otherTabBarButton: Button {
        return tabBar.button(withID: "Other")
    }
    var pageTabBarButton: Button {
        return tabBar.button(withID: "Page")
    }
    
}
