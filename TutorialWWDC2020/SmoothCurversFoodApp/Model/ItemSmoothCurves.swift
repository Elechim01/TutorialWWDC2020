//
//  ItemSmoothCurves.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 04/11/21.
//

import SwiftUI

struct ItemSmoothCurves: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var price: String
    var color: String
    var detail : String
}

var items : [ItemSmoothCurves] = [
    ItemSmoothCurves(image: "g1", title: "prova1", price: "&1", color: "SmoothC", detail: "prova1a"),
    ItemSmoothCurves(image: "g2", title: "prova2", price: "&2", color: "SmoothC1", detail: "prova2a"),
    ItemSmoothCurves(image: "g3", title: "prova3", price: "&3", color: "SmoothC2", detail: "prova3a"),
    ItemSmoothCurves(image: "g4", title: "prova4", price: "&4", color: "SmoothC3", detail: "prova4a")
]
