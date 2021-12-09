//
//  ViewCustomCarouselSliderParallaxEffect.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/12/21.
//

import SwiftUI

struct ViewCustomCarouselSliderParallaxEffect: View {
    var body: some View {
        HomeViewCustomCarouselSliderParallaxEffect()
    }
}

struct ViewCustomCarouselSliderParallaxEffect_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomCarouselSliderParallaxEffect()
    }
}

struct HomeViewCustomCarouselSliderParallaxEffect: View {
    
    @State var selected: Int = 0
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body: some View {
        TabView(selection: $selected){
            //            Images...
            ForEach(1...7,id:\.self){ index in
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                    //                Geometry Reader For Parallax Effect...
                    
                    GeometryReader{ reader in
                        Image("g\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        //                    moving view in opposite side
                        //                    when user starts to swipe..
                        //                    this will create parallax Effect...
                            .offset(x: -reader.frame(in: .global).midX)
                            .frame(width: width, height: height / 2)
                        
                    }
                    .frame(height: height / 2)
                    .cornerRadius(15)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(15)
                    //                shadow...
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: -5, y: -5)
                    //                decreasing width by padding...
                    //                so outer view only decreased...
                    //                inner image will be full width..
//                    bottom image...
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        .padding(5)
                        .background(Color.white)
                        .clipShape(Circle())
                        .offset(x: -15, y: 25)
                })
                    .padding(.horizontal,25)
            }
        }
        //        page Tab View...
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
