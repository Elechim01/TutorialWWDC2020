//
//  ProfileDetailModelComplexHeroAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

class ProfileDetailModelComplexHeroAnimations: ObservableObject {
    
    @Published var showProfile = false
    
//    Storing The Selected profile...
    @Published var selectedProfile: ProfileComplexHeroAnimations!
    
//    To Show Big Image...
    @Published var  showEnlargedImage = false
    
//    Drag to close...
    @Published var offset: CGFloat = 0
    
}

