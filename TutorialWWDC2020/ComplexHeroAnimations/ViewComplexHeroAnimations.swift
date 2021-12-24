//
//  ViewComplexHeroAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

struct ViewComplexHeroAnimations: View {
    
//    Animation Namespace...
    @Namespace var animation
    
//    StateObject...
    @StateObject var profileData = ProfileDetailModelComplexHeroAnimations()
    
    var body: some View {
        
        HomeViewComplexHeroAnimations(animation: animation)
//        setting Environment Object..
            .environmentObject(profileData)
        
    }
}

struct ViewComplexHeroAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ViewComplexHeroAnimations()
    }
}
