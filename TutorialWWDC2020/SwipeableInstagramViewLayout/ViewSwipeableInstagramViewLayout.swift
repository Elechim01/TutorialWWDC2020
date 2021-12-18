//
//  ViewSwipeableInstagramViewLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct ViewSwipeableInstagramViewLayout: View {
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        HomeViewSwipeableInstagramViewLayout(offset: $offset)
    }
}

struct ViewSwipeableInstagramViewLayout_Previews: PreviewProvider {
    static var previews: some View {
        ViewSwipeableInstagramViewLayout()
    }
}

// global usage Values...

var rectSwipeableInstagramViewLayout = UIScreen.main.bounds
var edgesSwipeableInstagramViewLayout = UIApplication.shared.windows.first?.safeAreaInsets
