//
//  ComicSearchBarWithCombine.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI

struct ComicSearchBarWithCombine:Identifiable ,Codable {
    var id: Int
    var title: String
    var description: String?
    var thumbnail: [String : String]
    var urls : [[String : String]]
    
}


struct APIComicResultSearchBarWithCombine: Codable {
    
    var data:APIComicCharacterDataSearchBarWithCombine
}

struct APIComicCharacterDataSearchBarWithCombine: Codable{
    var count: Int
    var results: [ComicSearchBarWithCombine]
}
