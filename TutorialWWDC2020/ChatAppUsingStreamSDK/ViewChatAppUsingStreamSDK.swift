//
//  ViewChatAppUsingStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI

struct ViewChatAppUsingStreamSDK: View {
    
    @StateObject var streamData = StreamViewModelChatAppUsingStreamSDK()
    @AppStorage("log_Status") var logStatus = false
    
    var body: some View {
        
        NavigationView{
           
            if !logStatus{
                LoginChatAppUsingStreamSDK()
                    .navigationTitle("Login")
            }else{
                
                ChannelViewChatAppusingStreamSDK()

            }
            
        }
        .alert(isPresented: $streamData.error) {
            Alert(title: Text(streamData.errorMsg))
        }
        .overlay(
            
            ZStack{
                
//                New Channel View..
                if streamData.createNewChannel{
                    CreateNewChannelChatAppUsingStreamSDK()
                }
                
//                Loading Screen...
                if streamData.isLoading{
                    LoadingScreenChatAppUsingStreamSDK()
                }
                                
            }
        )
        .environmentObject(streamData)
    }
}

struct ViewChatAppUsingStreamSDK_Previews: PreviewProvider {
    static var previews: some View {
        ViewChatAppUsingStreamSDK()
    }
}
