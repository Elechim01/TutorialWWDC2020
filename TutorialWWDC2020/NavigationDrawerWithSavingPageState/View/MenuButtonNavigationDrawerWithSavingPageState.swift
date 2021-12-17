//
//  MenuButtonNavigationDrawerWithSavingPageState.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct MenuButtonNavigationDrawerWithSavingPageState: View {
    
    var name: String
    var image: String
    @Binding var selectedMenu: String
    
    var animation: Namespace.ID
    
    var body: some View {
        Button {
            withAnimation(.spring()){
                selectedMenu = name
            }
        } label: {
            HStack(spacing: 15){
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(selectedMenu == name ? .black : .white)
                
                Text(name)
                    .foregroundColor(selectedMenu == name ? .black : .white)
            }
            .padding(.horizontal)
            .padding(.vertical,12)
            .frame(width: 200,alignment: .leading)
//            Smooth Slide Animation...
            .background(
                ZStack{
                    if selectedMenu == name{
                        Color.white
                            .cornerRadius(10)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }else{
                        Color.clear
                    }
                }
            )
        }

    }
}

struct MenuButtonNavigationDrawerWithSavingPageState_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationDrawerWithSavingPageState()
    }
}
