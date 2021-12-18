//
//  HomeViewScrollableTabBarWithSmoothScrollingTabEffect.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct HomeViewScrollableTabBarWithSmoothScrollingTabEffect: View {
    
    @State var offset: CGFloat = 0
    @State var showCapsule = false
    
    var body: some View {
        GeometryReader{ proxy in
            
            let rect = proxy.frame(in: .global)
            
            ScrollableTabBarScrollableTabBarWithSmoothScrollingTabEffect(tabs: tabsScrollableTabBarWithSmoothScrollingTabEffect , rect: rect, offset: $offset) {
                HStack(spacing: 0){
                    ForEach(image_URLs.indices,id:\.self){ index in
                        WebImage(url: URL(string: image_URLs[index]))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width)
                            .cornerRadius(0)
                            .overlay(Color.black.opacity(0.3))
                    }
                }
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
        .overlay(
//            Tab Bar....
            TabBarScrollableTabBarWithSmoothScrollingTabEffect(offset: $offset,showCapsule: $showCapsule),
            alignment: .top
        )
        .overlay(
//            Enlarge Capsule Button...
            Button(action: {
                withAnimation{
                    showCapsule.toggle()
                    
                }
            }, label: {
                Image(systemName: "fibrechannel")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.black)
                    .clipShape(Circle())
            })
            .padding()
            ,alignment: .bottomTrailing
        )
    }
}

struct HomeViewScrollableTabBarWithSmoothScrollingTabEffect_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewScrollableTabBarWithSmoothScrollingTabEffect()
    }
}

var tabsScrollableTabBarWithSmoothScrollingTabEffect = ["Home","Search","Account","Account"]
