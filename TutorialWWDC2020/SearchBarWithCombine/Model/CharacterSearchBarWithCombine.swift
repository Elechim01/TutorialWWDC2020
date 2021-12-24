//
//  CharacterSearchBarWithCombine.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI

struct CharacterSearchBarWithCombine: Identifiable,Codable {
    
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String : String]
    var urls : [[String : String]]
    
}


struct APIResultSearchBarWithCombine: Codable {
    
    var data:APICharacterDataSearchBarWithCombine
}

struct APICharacterDataSearchBarWithCombine: Codable{
    var count: Int
    var results: [CharacterSearchBarWithCombine]
}

