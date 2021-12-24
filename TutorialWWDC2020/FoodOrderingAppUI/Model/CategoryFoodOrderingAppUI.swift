//
//  CategoryFoodOrderingAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/12/21.
//

import SwiftUI

struct CategoryFoodOrderingAppUI: Identifiable {
    
    var id: String = UUID().uuidString
    var image: String
    var title: String
}
var categoriesFoodOrderingAppUI = [
    CategoryFoodOrderingAppUI(image: "p1", title: "Burger"),
    CategoryFoodOrderingAppUI(image: "p2", title: "Pizza"),
    CategoryFoodOrderingAppUI(image: "p3", title: "Sandwitch"),
    CategoryFoodOrderingAppUI(image: "p4", title: "Cupcake's"),
    
]

