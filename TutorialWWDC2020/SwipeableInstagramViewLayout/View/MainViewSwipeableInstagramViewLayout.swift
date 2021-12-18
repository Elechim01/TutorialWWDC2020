//
//  MainViewSwipeableInstagramViewLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct MainViewSwipeableInstagramViewLayout: View {
    
    @State var offset: CGFloat = rectSwipeableInstagramViewLayout.width 
    
    var body: some View {
//        Scrollable Tabs...
        
        GeometryReader{ reader in
            
            let frame = reader.frame(in: .global)
//            Since there are Three Vews...
            
            ScrollableTabBarSwipeableInstagramViewLayout(tabs: ["","",""], rect: frame, offset: $offset){
                
                PostViewSwipeableInstagramViewLayout(offset: $offset)
                
                HomeViewSwipeableInstagramViewLayout(offset: $offset)
                
                DirectViewSwipeableInstagramViewLayout(offset: $offset)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct MainViewSwipeableInstagramViewLayout_Previews: PreviewProvider {
    static var previews: some View {
        MainViewSwipeableInstagramViewLayout()
    }
}
