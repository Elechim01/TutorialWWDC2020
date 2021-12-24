//
//  HomeViewFoodOrderingAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/12/21.
//

import SwiftUI

struct HomeViewFoodOrderingAppUI: View {
    
//    Hiding Tab Bar...
    init(){
        UITabBar.appearance().isHidden = true
    }
    
//    selected Category...
    @State var selectedCategory: CategoryFoodOrderingAppUI = categoriesFoodOrderingAppUI.first!
    @State var selectedTab: String = "home"
    
    var body: some View {
        
//        Tab View....
        VStack(spacing: 0){
            TabView{
                LandingPageFoodOrderingAppUI(selectedCategory: $selectedCategory)
                    .tag("home")
                
                Color.pink
                    .tag("heart")
                
                Color.yellow
                    .tag("bell")
                
                Color.red
                    .tag("cart")
            }
            
//            Custom Tab Bar...
            CustomTabBarFoodOrderingAppUI(selectedTab: $selectedTab)
        }
        .ignoresSafeArea()
   
    }
}

struct HomeViewFoodOrderingAppUI_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewFoodOrderingAppUI()
    }
}

// Extending view To Get Screen Frame...
extension View{
    
    func getRectFoodOrderingAppUI() -> CGRect {
        return UIScreen.main.bounds
    }
}
