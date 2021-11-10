//
//  BagViewOnlineShopAppUIBag.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 09/11/21.
//

import SwiftUI

struct BagViewOnlineShopAppUIBag: View {
    
    var bagData : BagModel
    var animation: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            ZStack{
                
//                both image and color name are same...
                Color.blue
                    .cornerRadius(15)
                
                Image(bagData.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .matchedGeometryEffect(id: bagData.image, in: animation)
            }
            
            Text(bagData.title)
                .fontWeight(.heavy)
                .foregroundColor(.gray)
            
            Text(bagData.price)
                .fontWeight(.heavy)
                .foregroundColor(.black)
        }
    }
}

