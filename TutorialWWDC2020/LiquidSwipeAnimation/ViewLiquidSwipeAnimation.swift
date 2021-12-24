//
//  ViewLiquidSwipeAnimation.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 20/12/21.
//

import SwiftUI

struct ViewLiquidSwipeAnimation: View {
    var body: some View {
        HomeViewLiquidSwipeAnimation()
    }
}

struct ViewLiquidSwipeAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ViewLiquidSwipeAnimation()
    }
}

struct HomeViewLiquidSwipeAnimation:View {
    
//    Liquidi Swipe Offset..
    @State var offset: CGSize = .zero
    
    @State var showHome = false
    
    var body: some View{
        ZStack{
            Color.purple
                .overlay(
//                    Content...
                    VStack(alignment: .leading, spacing: 10, content: {
                        Text("For Gamers")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Text("fiuerhferòfjnòenfvehfiuefhewòionfweaklnvlkw")
                            .font(.caption)
                            .fontWeight(.bold)
                        
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal,30)
                    .offset(x: -15)
                )
                .clipShape(LiquidSwipe(offset: offset))
                .ignoresSafeArea()
//            arrow...
                .overlay(
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
//                    For Draggesture to identify..
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onChanged({ value in
                            
//                            animating swipe offset...
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)){
                                offset = value.translation
                            }
                            
                        }).onEnded({ value in
                            
                            let screen = UIScreen.main.bounds
                            
                            withAnimation(.spring()){
//                               validating...
                                if -offset.width > screen.width / 2{
//                                    removing view...
                                    offset.width = -screen.height
                                    showHome.toggle()
                                }else{
                                    offset = .zero
                                }
                            }
                        }))
                        .offset(x: 15,y: 58)
//                         hiding while dragging starts...
                    
                    ,alignment: .topTrailing
                )
                .padding(.trailing)
            
            if showHome{
                Text("Welcome To Home!!!")
                    .fontWeight(.heavy)
                    .onTapGesture {
//                        resettng View...
//                        Just for tutorial..
//                        customize for your own...
                        withAnimation(.spring()){
                            offset = .zero
                            showHome.toggle()
                        }
                    }
            }
            
        }
    }
}

// Custom Shape..
struct LiquidSwipe: Shape{
    
//    getting Offset Value...
    var offset: CGSize
    
//    animating Path...
    var animatableData: CGSize.AnimatableData{
        get{return offset.animatableData}
        set{offset.animatableData = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            
//            when user moves left...
//            increasing size both in top and bottom..
//            so it will create a liquid swipe effect...
            
            
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)
            
//            First constructing Rectangle Sahpe...
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
//            Now Constructing Curve Shape...
            let from = 80 + (offset.width)
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            
//            Also Adding height..
            var to = 180 + (offset.height) + (-offset.width)
            to = to < 180 ? 180 : to
            
//            Mid Between 80 - 180....
            let mid : CGFloat = 80 + ((to - 80) / 2)

            
            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
            
        }
    }
}
