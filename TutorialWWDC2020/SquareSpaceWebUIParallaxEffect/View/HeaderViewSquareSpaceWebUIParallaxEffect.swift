//
//  HeaderViewSquareSpaceWebUIParallaxEffect.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 16/12/21.
//

import SwiftUI

struct HeaderViewSquareSpaceWebUIParallaxEffect: View {
    var body: some View {
        //            HeaderView....
        HStack{
            
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "line.horizontal.3")
                    .font(.title2)
            }
            
        }
        .padding()
        .overlay(
            //                Title...
            Text("SquareSpace")
                .font(.title2)
                .fontWeight(.bold)
        )
        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color.black)
        .foregroundColor(.white)
        //            Shadow...
        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
    }
}

struct HeaderViewSquareSpaceWebUIParallaxEffect_Previews: PreviewProvider {
    static var previews: some View {
        HeaderViewSquareSpaceWebUIParallaxEffect()
    }
}
