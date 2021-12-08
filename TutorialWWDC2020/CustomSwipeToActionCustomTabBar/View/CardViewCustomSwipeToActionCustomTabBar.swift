//
//  CardViewCustomSwipeToActionCustomTabBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 07/12/21.
//

import SwiftUI

struct CardViewCustomSwipeToActionCustomTabBar: View {
    var item :ItemsCustomSwipeToActionCustomTabBar
    var body: some View {
        
        HStack{
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width / 3.2)
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(item.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Text(item.subTitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(item.price)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
            }
            
            Spacer(minLength: 0)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
    
    }
}

