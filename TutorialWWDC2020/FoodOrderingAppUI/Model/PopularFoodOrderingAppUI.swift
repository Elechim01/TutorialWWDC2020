//
//  PopularFoodOrderingAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/12/21.
//

import SwiftUI

//Model And Sample Data...
struct PopularFoodOrderingAppUI: Identifiable {

    var id = UUID().uuidString
    var title: String
    var description: String
    var image: String
    var price: String
}

var popular_Items = [
    PopularFoodOrderingAppUI(title: "p1", description: "p1", image: "p1", price: "$1"),
    PopularFoodOrderingAppUI(title: "p2", description: "p2", image: "p2", price: "$2")

]

