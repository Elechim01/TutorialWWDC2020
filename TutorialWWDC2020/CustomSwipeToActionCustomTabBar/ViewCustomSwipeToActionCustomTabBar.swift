//
//  ViewCustomSwipeToActionCustomTabBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 07/12/21.
//

import SwiftUI

struct ViewCustomSwipeToActionCustomTabBar: View {
    
//    hiding tab bar...
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabBarCustomSwipeToActionCustomTabBar()
    }
}

struct ViewCustomSwipeToActionCustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomSwipeToActionCustomTabBar()
    }
}
