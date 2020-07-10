//
//  PageScreen.swift
//  TABTestKit_ExampleUITests
//
//  Created by Ben Gilroy on 10/07/2020.
//  Copyright © 2020 The App Business LTD. All rights reserved.
//

import TABTestKit

let pageScreen = PageScreen()

struct PageScreen: Screen {
  
    var trait: View { return view }
    let view = View(id: "PageView")
    var scrollView: ScrollView { ScrollView(parent: view) }
    var pageIndicator: PageIndicator { PageIndicator(parent: view) }

}
