//
//  FoodAnimatedStickyHeaderWithScrollableTabs.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

struct FoodAnimatedStickyHeaderWithScrollableTabs: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var price: String
    var image: String
}

var foodsAnimatedStickyHeaderWithScrollableTabs = [
    FoodAnimatedStickyHeaderWithScrollableTabs(title: "Chocolate Cake", description: "Chocolate cake or chocolate gateau", price: "19$", image: "p1"),
    FoodAnimatedStickyHeaderWithScrollableTabs(title: "Cookies", description: "Chocolate cake or chocolate gateau", price: "29$", image: "p2"),
    FoodAnimatedStickyHeaderWithScrollableTabs(title: "Sandwich", description: "Chocolate cake or chocolate gateau", price: "9$", image: "p3"),
    FoodAnimatedStickyHeaderWithScrollableTabs(title: "French Fires", description: "Chocolate cake or chocolate gateau", price: "10$", image: "p4"),
    FoodAnimatedStickyHeaderWithScrollableTabs(title: "Piaza", description: "Chocolate cake or chocolate gateau", price: "15$", image: "p5"),
]
