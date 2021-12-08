//
//  CardViewE-CommerceApp.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 06/12/21.
//

import SwiftUI

struct CardViewE_CommerceApp: View {
    
    var item: ItemE_Commerce
    var animation : Namespace.ID
    
    var body: some View {
        
        VStack{
            
            HStack{
                Spacer(minLength: 0)
                
                Text(item.price)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical,8)
                    .padding(.horizontal,10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
            }
            
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .matchedGeometryEffect(id: "image\(item.id)", in: animation)
                .padding(.top,30)
                .padding(.bottom)
                .padding(.horizontal,10)
            
            Text(item.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(item.subTitle)
                .font(.caption)
                .foregroundColor(.gray)
            
//            using Matched Geometry Effect For Hero Animation...
            HStack{
                Button {
                     
                } label: {
                    Image(systemName: "suit.heart")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                .matchedGeometryEffect(id: "heart\(item.id)", in: animation)
                
                Spacer(minLength: 0)
                
                Text(item.rating)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .matchedGeometryEffect(id: "rating\(item.id)", in: animation)

            }
            .padding()
            
        }
//        giving heo effect for color also...
        .background(Color.red
                        .matchedGeometryEffect(id: "color\(item.id)", in: animation)
        )
       
//        .background(Color(item.image))
        .cornerRadius(15)
     
    }
}

struct CardViewE_CommerceApp_Previews: PreviewProvider {
    static var previews: some View {
        E_CommerceAppView()
    }
}
