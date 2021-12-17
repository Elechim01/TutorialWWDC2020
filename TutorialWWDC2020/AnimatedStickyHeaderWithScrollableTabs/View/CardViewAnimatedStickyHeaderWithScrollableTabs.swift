//
//  CardViewAnimatedStickyHeaderWithScrollableTabs.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

struct CardViewAnimatedStickyHeaderWithScrollableTabs: View {
    var food: FoodAnimatedStickyHeaderWithScrollableTabs
    var body: some View {
        
        HStack{
            VStack(alignment: .leading, spacing: 10) {
                
                Text(food.title)  
                    .fontWeight(.bold)
                
                Text(food.description)
                    .font(.caption)
                    .lineLimit(3)
                
                Text(food.price)
                    .fontWeight(.bold)
            }
            
            Spacer(minLength: 10)
            
            Image(food.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 130)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct CardViewAnimatedStickyHeaderWithScrollableTabs_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewAnimatedStickyHeaderWithScrollableTabs()
    }
}
