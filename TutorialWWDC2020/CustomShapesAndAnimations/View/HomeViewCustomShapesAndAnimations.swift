//
//  HomeViewCustomShapesAndAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

struct HomeViewCustomShapesAndAnimations: View {
    
    @State var selectedTab = "house"
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            Color.purple
                .ignoresSafeArea()
            
//            Custom Tab Bar...
            CustomTabBarCustomShapesAndAnimations(selectedTab: $selectedTab)
            
        }
        
    }
}

struct HomeViewCustomShapesAndAnimations_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewCustomShapesAndAnimations()
    }
}
