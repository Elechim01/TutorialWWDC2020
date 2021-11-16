//
//  User.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/11/21.
//

import SwiftUI

struct UserCustomSearchBar: Decodable,Hashable {
    var node_id: String
    var login: String
    var avatar_url : String
}
struct Results: Decodable {
    var items: [UserCustomSearchBar]
    
}

