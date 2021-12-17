//
//  HomeViewNavigationDrawerWithSavingPageState.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI
import MapKit

struct HomeViewNavigationDrawerWithSavingPageState: View {
    
//    Hiding tab Bar...
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @StateObject var menuData = MenuViewModelNavigationDrawerWithSavingPageState()
    
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0){
            
//            Drawer And Main view...
            
//            Drawer...
            DrawerNavigationDrawerWithSavingPageState(animation: animation)
            
//            Main view...
            
            TabView(selection: $menuData.selectedMenu){
                
                CatalogueNavigationDrawerWithSavingPageState()
                    .tag("Catalogue")
                
                OrdersNavigationDrawerWithSavingPageState()
                    .tag("Your Orders")
                
                CartNavigationDrawerWithSavingPageState()
                    .tag("Your Cart")
                
                FavouritesNavigationDrawerWithSavingPageState()
                    .tag("Favourites")
                
            }
            .frame(width: UIScreen.main.bounds.width)
        }
//        Max Frame...
        .frame(width: UIScreen.main.bounds.width)
//        Moving View...
//        250 / 2 => 125
        .offset(x: menuData.showDrawer ? 125 : -125)
        .overlay(
            
            ZStack{
                if !menuData.showDrawer{
                    DrawerNavigationDrawerWithSavingPageState(animation: animation)
                        .padding()
                }
            },
            alignment: .topLeading
           
        )
        
//        Setting As Enviroment Objects...
//        For Avoiding Re-Declarations...
        .environmentObject(menuData)
        
        
    }
}

struct HomeViewNavigationDrawerWithSavingPageState_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewNavigationDrawerWithSavingPageState()
    }
}
