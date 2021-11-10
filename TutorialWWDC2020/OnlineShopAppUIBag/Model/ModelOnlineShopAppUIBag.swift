//
//  ModelOnlineShopAppUIBag.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 09/11/21.
//

import SwiftUI

//Model Data...

struct BagModel: Identifiable {
    var id = UUID().uuidString
    var image : String
    var title : String
    var price: String
}

var bags = [
    BagModel(image: "g1", title: "p1", price: "∞"),
    BagModel(image: "g2", title: "p2", price: "∞"),
    BagModel(image: "g3", title: "p3", price: "∞"),
    BagModel(image: "g4", title: "p4", price: "∞"),
    BagModel(image: "g5", title: "p5", price: "∞"),
    BagModel(image: "g6", title: "p6", price: "∞"),
    
]

var scroll_Tabs = ["Hand Bag","Jewellery","Footwear","Dresses","Beauty"]
