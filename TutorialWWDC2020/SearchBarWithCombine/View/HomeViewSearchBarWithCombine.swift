//
//  HomeViewSearchBarWithCombine.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI

struct HomeViewSearchBarWithCombine: View {
    
    @StateObject var homeData = HomeViewModelSearchBarWithCombine()
    
    var body: some View {
        
        TabView{
//            Characters View..
            CharactersViewSearchBarWithCombine()
                .tabItem {
                    Image(systemName: "person.3.fill")
                   Text("Characters")
                }
//            setting Enviroment Object...
//            so that we can access dara on charecter View...
                .environmentObject(homeData)
            
            ComicsViewSearchBarWithCombine()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
                .environmentObject(homeData)
        }
    }
}

struct HomeViewSearchBarWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSearchBarWithCombine()
    }
}
