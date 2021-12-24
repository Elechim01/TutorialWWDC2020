//
//  LoadingScreenChatAppUsingStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI

struct LoadingScreenChatAppUsingStreamSDK: View{
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            Color.primary
                .opacity(0.2)
                .ignoresSafeArea()
            
            ProgressView()
                .frame(width: 50, height: 50)
                .background(colorScheme == .dark ? Color.black : Color.white)
                .cornerRadius(8)
        }
    }
}

struct LoadingScreenChatAppUsingStreamSDK_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreenChatAppUsingStreamSDK()
    }
}
