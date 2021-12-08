//
//  CardViewSearchBarInNavigationBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/12/21.
//

import SwiftUI

struct CardViewSearchBarInNavigationBar: View {
    
    var item: AppItemSearchBarInNavigationBar
    
    @State var show:Bool = false
    
    var body: some View {
        HStack(spacing: 15){
            Image(item.name)
                .resizable()
                .frame(width: 65, height: 65)
            
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(item.name)
                            .font(.title2)
                        
                        Text(item.source)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer(minLength: 10)
                    
                    VStack{
                        Button {
                            show.toggle()
                        } label: {
                            Text(show ? "Open":"GET")
                                .fontWeight(.heavy)
                                .padding(.vertical,8)
                                .padding(.vertical,20)
                                .background(Color.primary.opacity(0.1))
                                .clipShape(Capsule())
                        }
                        
                        Text("In App Purchase")
                            .font(.caption2)
                            .foregroundColor(.gray)

                    }
                }
                
                Divider()
                
            }
        }
        .padding(.horizontal)
    }
}
 
