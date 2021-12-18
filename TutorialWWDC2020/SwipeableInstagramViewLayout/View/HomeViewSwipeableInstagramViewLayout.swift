//
//  HomeViewSwipeableInstagramViewLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct HomeViewSwipeableInstagramViewLayout: View {
    
    @State var selectedTab = "house.fill"
    
    
//    to Update For Dark Mode...
    @Environment(\.colorScheme) var scheme
    
    @Binding var offset: CGFloat
    
    var body: some View {
//        Instagram Home view...
        TabView(selection: $selectedTab) {
            
            FeedViewSwipeableInstagramViewLayout(offset: $offset)
                .padding(.top,edgesSwipeableInstagramViewLayout?.top)
                .tag("house.fill")
            
            Text("Search")
                .tag("magnifyingglass")
            
            Text("Reels")
                .tag("airplayvideo")
            
            Text("Liked")
                .tag("suit.heart.fill")
            
            Text("Account")
                .tag("person.circle")
        }
        .overlay(
            
//            custom Tab Bar....
            
            VStack(spacing: 12){
                Divider()
                    .padding(.horizontal,-15)
                
                HStack(spacing: 0){
                    
                    TabBarButtonSwipeableInstagramViewLayout(image: "house.fill", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    
                    TabBarButtonSwipeableInstagramViewLayout(image: "magnifyingglass", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    
                    TabBarButtonSwipeableInstagramViewLayout(image: "airplayvideo", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    
                    TabBarButtonSwipeableInstagramViewLayout(image: "suit.heart.fill", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    
                    TabBarButtonSwipeableInstagramViewLayout(image: "person.circle", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
                .padding(.bottom, edgesSwipeableInstagramViewLayout?.bottom ?? 15)
            .background(scheme == .dark ? Color.black : Color.white)
            
            
            ,alignment: .bottom
        )
        .ignoresSafeArea()
    }
}

// Tab Bar Button...

struct TabBarButtonSwipeableInstagramViewLayout: View{
    
    var image: String
    @Binding var selectedTab: String
    
    var body: some View{
        Button {
            selectedTab = image
        } label: {
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(selectedTab == image ? .primary : .gray)
        }

    }
}

