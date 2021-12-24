//
//  LoginChatAppUsingStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI

struct LoginChatAppUsingStreamSDK: View {
    
    @EnvironmentObject var streamData: StreamViewModelChatAppUsingStreamSDK
//    changing based on ColorScheme
    @Environment (\.colorScheme) var colorScheme
    var body: some View {
        
        VStack{
            TextField("Michele", text: $streamData.userName)
                .modifier(ShadowModifierChatAppUsingStreamSDK())
                .padding(.top,30)
            
            Button {
                streamData.logInUser()
            } label: {
                HStack{
                    
                    Spacer()
                    
                    Text("Login")
                    
                    Spacer()
                    
                    Image(systemName: "arrow.light")
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.primary)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .cornerRadius(5)
            }
            .padding(.top,20)
            .disabled(streamData.userName == "")
            .opacity(streamData.userName == "" ? 0.5 : 1)

            Spacer()
            
        }
        .padding()
    }
}

struct LoginChatAppUsingStreamSDK_Previews: PreviewProvider {
    static var previews: some View {
        LoginChatAppUsingStreamSDK()
    }
}

// Creating a Modifier For Shadow so that it can be used for some other views...
struct ShadowModifierChatAppUsingStreamSDK:ViewModifier {
    
//    changing based on ColorScheme
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
            return content
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(colorScheme != .dark ? Color.white : Color.black)
            .cornerRadius(8)
            .clipped()
            .shadow(color: Color.primary.opacity(0.04), radius: 5, x: 5, y: 5)
            .shadow(color: Color.primary.opacity(0.04), radius: 5, x: -5, y: -5)

    }
}
