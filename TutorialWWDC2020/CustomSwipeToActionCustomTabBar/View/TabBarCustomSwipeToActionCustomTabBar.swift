//
//  TabBarCustomSwipeToActionCustomTabBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 07/12/21.
//

import SwiftUI

struct TabBarCustomSwipeToActionCustomTabBar: View {
    
    @State var current = "Home"
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            
            TabView(selection: $current) {
                
                HomeCustomSwipeToActionCustomTabBar()
                    .tag("Home")
                
                Text("Messages")
                    .tag("Messages")
                
                Text("Account")
                    .tag("Account")
            }
            
            HStack(spacing: 0){
                
//                TabButton...
                TabButtonCustomSwipeToActionCustomTabBar(title: "Home", image: "house", selected: $current)
                
                Spacer(minLength: 0)
                
                TabButtonCustomSwipeToActionCustomTabBar(title: "Messages", image: "message", selected: $current)
                
                Spacer(minLength: 0)
                
                TabButtonCustomSwipeToActionCustomTabBar(title: "Account", image: "person", selected: $current)
            }
            .padding(.vertical,12)
            .padding(.horizontal)
            .background(Color.black)
            .clipShape(Capsule())
            .padding(.horizontal,25)
        }
    }
}

