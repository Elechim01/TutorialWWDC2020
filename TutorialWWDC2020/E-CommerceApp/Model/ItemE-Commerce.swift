//
//  ItemE-Commerce.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 06/12/21.
//

import SwiftUI

struct ItemE_Commerce: Identifiable {
    
    var id = UUID().uuidString
    var title: String
    var subTitle: String
    var price: String
    var rating: String
    var image: String
}

//Note Both Image And Color Name Are Same...


var itemsecommerce = [
    ItemE_Commerce(title: "prova1", subTitle: "prova1", price: "200€", rating: "10", image: "p0"),
    ItemE_Commerce(title: "prova2", subTitle: "prova2", price: "200€", rating: "10", image: "p1"),
    ItemE_Commerce(title: "prova3", subTitle: "prova3", price: "200€", rating: "10", image: "p2"),
    ItemE_Commerce(title: "prova4", subTitle: "prova4", price: "200€", rating: "10", image: "p3"),
    ItemE_Commerce(title: "prova5", subTitle: "prova5", price: "200€", rating: "10", image: "p4"),
    ItemE_Commerce(title: "prova6", subTitle: "prova6", price: "200€", rating: "10", image: "p5"),
]

