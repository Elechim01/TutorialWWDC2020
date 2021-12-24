//
//  CreateNewChannelChatAppUsingStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI

struct CreateNewChannelChatAppUsingStreamSDK: View {
    
    @EnvironmentObject var streamData: StreamViewModelChatAppUsingStreamSDK
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text("Create New Channel")
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("Michele", text: $streamData.channelName)
                .modifier(ShadowModifierChatAppUsingStreamSDK())
            
//            Button...
            Button {
                streamData.createChannel()
            } label: {
                Text("Create Channel")
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.primary)
                    .foregroundColor(scheme == .dark ? .black : .white)
                    .cornerRadius(8)
            }
            .padding(.top,10)
            .disabled(streamData.channelName == "")
            .opacity(streamData.channelName == "" ? 0.5 : 1)

            
        }
        .padding()
        .background(scheme == .dark ? Color.black : Color.white)
        .cornerRadius(12)
        .padding(.horizontal,35)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.2).ignoresSafeArea().onTapGesture(perform: {
            
            streamData.channelName = ""
            withAnimation {
                streamData.createNewChannel.toggle()
            }
        }))
    }
}

struct CreateNewChannelChatAppUsingStreamSDK_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewChannelChatAppUsingStreamSDK()
    }
}
