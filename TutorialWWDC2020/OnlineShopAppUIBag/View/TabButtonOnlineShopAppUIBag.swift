//
//  TabButtonOnlineShopAppUIBag.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 09/11/21.
//

import SwiftUI

struct TabButtonOnlineShopAppUIBag: View {
    
    var title: String
    @Binding var selectedTab: String
    var animation : Namespace.ID
    
    var body: some View {
        Button {
            
            withAnimation(.spring()){
                selectedTab = title
            }
            
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .fontWeight(.heavy)
                    .foregroundColor(selectedTab == title ? .black : .gray)
                
//             Adding animation....
                
                if selectedTab == title{
                    
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 40, height: 4)
                        .matchedGeometryEffect(id: "Tab", in: animation)
                }
            }
//            default width..
            .frame(width: 100)
        }

    }
}
