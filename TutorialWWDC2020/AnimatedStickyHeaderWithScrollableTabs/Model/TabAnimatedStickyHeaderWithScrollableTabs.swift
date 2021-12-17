//
//  TabAnimatedStickyHeaderWithScrollableTabs.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

// Tab Model Width Tab items...

struct TabAnimatedStickyHeaderWithScrollableTabs: Identifiable {
    var id = UUID().uuidString
    var tab : String
    var foods: [FoodAnimatedStickyHeaderWithScrollableTabs]
}
var tabsItemsAnimatedStickyHeaderWithScrollableTabs = [
    TabAnimatedStickyHeaderWithScrollableTabs(tab: "Order Again", foods: foodsAnimatedStickyHeaderWithScrollableTabs.shuffled()),
    TabAnimatedStickyHeaderWithScrollableTabs(tab: "Picker For You", foods: foodsAnimatedStickyHeaderWithScrollableTabs.shuffled()),
    TabAnimatedStickyHeaderWithScrollableTabs(tab: "Starters", foods: foodsAnimatedStickyHeaderWithScrollableTabs.shuffled()),
    TabAnimatedStickyHeaderWithScrollableTabs(tab: "Gimpub Sushi", foods: foodsAnimatedStickyHeaderWithScrollableTabs.shuffled())
]

