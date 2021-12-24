//
//  PopularItemRowViewFoodOrderingAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/12/21.
//

import SwiftUI

struct PopularItemRowViewFoodOrderingAppUI: View {
    
    var item: PopularFoodOrderingAppUI
    
    var body: some View {
        VStack(spacing: 15){
            Image(systemName: "flame")
                .font(.footnote)
                .foregroundColor(.red)
                .padding(8)
                .background(Color.orange.opacity(0.1))
                .clipShape(Circle())
//            Setting it to right..
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(-10)
            
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRectFoodOrderingAppUI().width / 3)
                .padding(.top,6)
            
            Text(item.title)
                .fontWeight(.bold)
            
            Text(item.description)
                .font(.footnote)
                .foregroundColor(.gray)
            
            (
                Text("$")
                    .font(.footnote)
                    .foregroundColor(.pink)
                +
                Text(item.price)
                    .font(.title2)
                    .foregroundColor(.black)
            )
            .fontWeight(.bold)
            .padding(.top,8)
        }
        .padding(.horizontal,30)
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(25)
//        shadows...
        .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
    }
}

struct PopularItemRowViewFoodOrderingAppUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewFoodOrderingAppUI()
    }
}
