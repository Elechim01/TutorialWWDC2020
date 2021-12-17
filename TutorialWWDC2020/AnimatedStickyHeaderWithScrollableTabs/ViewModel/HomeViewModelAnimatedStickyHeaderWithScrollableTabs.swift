//
//  HomeViewModelAnimatedStickyHeaderWithScrollableTabs.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

class HomeViewModelAnimatedStickyHeaderWithScrollableTabs: ObservableObject {
    @Published var offset: CGFloat = 0
    
//    Selected Tab...
    @Published var selectedtab = tabsItemsAnimatedStickyHeaderWithScrollableTabs.first!.tab
    
}
