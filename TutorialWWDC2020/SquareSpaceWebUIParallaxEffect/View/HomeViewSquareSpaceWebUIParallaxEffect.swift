//
//  HomeViewSquareSpaceWebUIParallaxEffect.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 16/12/21.
//

import SwiftUI

struct HomeViewSquareSpaceWebUIParallaxEffect: View {
    
    @State var firstMiniY: CGFloat = 0
    
//    Stopping bounces On ScrollView...
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    @State var minY: CGFloat = 0
    @State var lastMinY: CGFloat = 0
    @State var scale: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0){
            
            HeaderViewSquareSpaceWebUIParallaxEffect()
          
            ScrollView{
                
//                Top Sticky View...
                StickyViewSquareSpaceWebUIParallaxEffect(firstMinY: $firstMiniY,minY: $minY,lastMinY: $lastMinY,scale:$scale)
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    ForEach(subTitlesSquareSpaceWebUIParallaxEffect,id:\.self){ title in
                        Section {
                            Text("prova 1 ciao bello ")
                        } header: {
                            Text(title)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                }
                .padding()
//                since were moving view up...
                .padding(.bottom,lastMinY)
                .background(Color.white)
                .offset(y: scale > 0.4 ? minY : lastMinY)
                
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea(.all, edges: .all))
        .offset(y: scale > 0.4 ? minY : lastMinY)
    }
}

let subTitlesSquareSpaceWebUIParallaxEffect = ["Award Winning\nWeb Designs","Flexible Portfolios","Blogging Tools","Built-in SEO Tools","Analytics"]

struct HomeViewSquareSpaceWebUIParallaxEffect_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSquareSpaceWebUIParallaxEffect()
    }
}

// Extending view To Get Screen Rect...

extension View{
    
    func getScreen() -> CGRect {
        return UIScreen.main.bounds
    }
}
