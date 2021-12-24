//
//  HomeViewCustomSlideOutMenu.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

struct HomeViewCustomSlideOutMenu: View {
    
    @Binding var selectedTab: String
    
//    Hiding Tab Bar...
    init(selectedTab: Binding<String>){
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
//        Tab view With Tabs...
        TabView(selection: $selectedTab) {
            
//            Views...
            HomePageCustomSlideOutMenu()
                .tag("Home")
            
            HistoryCustomSlideOutMenu()
                .tag("History")
            
            SettingsCustomSlideOutMenu()
                .tag("Settings")
            
            HelpCustomSlideOutMenu()
                .tag("Help")
            
            NotificationsCustomSlideOutMenu()
                .tag("Notifications")
        }
    }
}

struct HomeViewCustomSlideOutMenu_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomSlideOutMenu()
    }
}

// All Sub View..

struct HomePageCustomSlideOutMenu:View {
    
    var body: some View{
        NavigationView{
            
            VStack(alignment: .leading, spacing: 20){
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRectCustomSlideOutMenu().width - 50, height: 400)
                    .cornerRadius(20)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Jenna Ezarik")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("iJustine's Sister, YoutTuber,Techie....")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                
            }
            .navigationTitle("Home")
        }
    }
}

struct HistoryCustomSlideOutMenu:View {
    
    var body: some View{
        NavigationView{
            Text("Home")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("History")
        }
    }
}

struct NotificationsCustomSlideOutMenu:View {
    
    var body: some View{
        NavigationView{
            Text("Notifications")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Notifications")
        }
    }
}

struct SettingsCustomSlideOutMenu:View {
    
    var body: some View{
        NavigationView{
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Settings")
        }
    }
}

struct HelpCustomSlideOutMenu:View {
    
    var body: some View{
        NavigationView{
            Text("Help")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Help")
        }
    }
}
