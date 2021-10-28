//
//  Recipe.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 28/10/21.
//

import SwiftUI
struct Recipe {
    var image: String
    var title : String
    var detail: String
    var rating: String
    var type: String
    var color : Color
}
var recipes = [
    Recipe(image: "p2", title: "prova1", detail: "eiojfewiojdwe", rating: "4.5", type: "semplice", color: Color("blueRecipe")),
    Recipe(image: "p3", title: "prova1", detail: "eiojfewiojdwe", rating: "4.5", type: "difficile", color: Color("redRecipe")),
    
]
var categories = ["Fruits","Meats","Sushi","Fries"]
