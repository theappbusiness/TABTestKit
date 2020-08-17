//
//  PageScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Ben Gilroy on 10/07/2020.
//  Copyright © 2020 Kin + Carta. All rights reserved.
//

import TABTestKit

let pageScreen = PageScreen()

struct PageScreen: Screen {
    
    var trait: View { return view }
    let view = View(id: "PageView")
    var scrollView: ScrollView { return ScrollView(parent: view) }
    var pageIndicator: PageIndicator { return PageIndicator(parent: view) }
    
}
