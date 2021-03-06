//
//  TabButtonE-CommerceApp.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 06/12/21.
//

import SwiftUI

struct TabButtonE_CommerceApp: View {
    
    var title: String
    @Binding var selected: String
    
    var animation: Namespace.ID
    
    var body: some View {
        Button {
            withAnimation(.spring()){
                selected = title
            }
        } label: {
            Text(title)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(selected == title ? .white : .black)
                .padding(.vertical,10)
                .padding(.horizontal,selected == title ? 20 : 0)
                .background(
//                    For Slide Effect Animation...
                    ZStack{
                        
                        if selected == title{
                        
                        Color.black
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "Tab", in: animation)
                        }
                    }
                )
        }

    }
}

