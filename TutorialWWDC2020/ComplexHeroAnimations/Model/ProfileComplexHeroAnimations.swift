//
//  ProfileComplexHeroAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

struct ProfileComplexHeroAnimations: Identifiable {
  
    var id = UUID().uuidString
    var userName: String
    var profile: String
    var lastMsg: String
    var time: String
}

let recents = [
    ProfileComplexHeroAnimations(userName: "Mich1", profile: "p1", lastMsg: "hola", time: "10:25"),
    ProfileComplexHeroAnimations(userName: "Mich2", profile: "p2", lastMsg: "hola1", time: "10:26"),
    ProfileComplexHeroAnimations(userName: "Mich3", profile: "p3", lastMsg: "hola2", time: "10:27"),
    ProfileComplexHeroAnimations(userName: "Mich4", profile: "p4", lastMsg: "hola3", time: "10:28"),
    ProfileComplexHeroAnimations(userName: "Mich5", profile: "p5", lastMsg: "hola4", time: "10:29"),

    
]

