//
//  PostSwipeableInstagramViewLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

// Post Model And Data....

struct PostSwipeableInstagramViewLayout: Identifiable {
    
    var id = UUID().uuidString
    var user: String
    var profile: String
    var postImage: String
    var postTitle: String
    var time: String
}

var postSwipeableInstagramViewLayout = [
    PostSwipeableInstagramViewLayout(user: "Michele", profile: "p1", postImage: "g2", postTitle: "prova1", time: "23 min fa"),
    PostSwipeableInstagramViewLayout(user: "Gianni", profile: "p2", postImage: "g2", postTitle: "prova2", time: "26 min fa"),
    PostSwipeableInstagramViewLayout(user: "Procton", profile: "p3", postImage: "g2", postTitle: "prova3", time: "33 min fa"),
    PostSwipeableInstagramViewLayout(user: "Koji", profile: "p4", postImage: "g2", postTitle: "prova4", time: "40 min fa"),
    PostSwipeableInstagramViewLayout(user: "Actarus", profile: "p5", postImage: "g2", postTitle: "prova5", time: "53 min fa"),
]

