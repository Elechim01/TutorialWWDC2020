//
//  ItemViewSmoothCurves.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 04/11/21.
//

import SwiftUI

struct ItemViewSmoothCurves: View {
    var item : ItemSmoothCurves
    var body: some View {
        VStack(spacing: 12){
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width / 3, height: 150)
                .clipShape(Circle())
//                .padding()
            
            HStack(spacing: 8){
                Spacer(minLength: 0)
                
                Text(item.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)
                
                Text(item.price)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,8)
                    .background(Color(item.color))
                    .clipShape(CustomCornerSmoothCurves(corner: [.topLeft,.topRight,.bottomLeft], size: 10))
            }
        }
        .padding(.top)
        .padding(.leading)
        .padding([.bottom,.trailing],5)
        .background(Color(item.color).opacity(0.7)
                        .clipShape(CustomCornerSmoothCurves(corner: [.topLeft,.topRight,.bottomLeft], size: 25))
                        .padding(.top,55)
        )
        .padding(.trailing)
        .padding(.leading)
//        Custom Shape...
       
        
    }
}

