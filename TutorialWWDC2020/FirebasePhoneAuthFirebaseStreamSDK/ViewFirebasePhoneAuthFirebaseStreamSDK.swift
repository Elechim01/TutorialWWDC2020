//
//  ViewFirebasePhoneAuthFirebaseStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 26/12/21.
//

import SwiftUI

struct ViewFirebasePhoneAuthFirebaseStreamSDK: View {
    @StateObject var model = LoginViewModelFirebasePhoneAuthFirebaseStreamSDK()
    @StateObject var streamData = StreamViewModelChatAppUsingStreamSDK()
    @AppStorage("log_Status") var logStatus = false
    
    var body: some View {
        
        NavigationView{
//
            if !logStatus{
                if model.newUser{
                    LoginChatAppUsingStreamSDK()
                        .environmentObject(streamData)
                        .navigationTitle("Register")
                }else{
                    OtpLoginFirebasePhoneAuthFirebaseStreamSDK()
                        .environmentObject(model)
                        .navigationTitle("Login")
                }
            }else{
                
                ChannelViewChatAppusingStreamSDK()

            }
            
        }
//       Since we have different alerts...
        .background(
            
            ZStack{
                
                Text("")
                    .alert(isPresented: $streamData.error) {
                        Alert(title: Text("Message"), message: Text(streamData.errorMsg), dismissButton:
                                    .destructive(Text("OK"),action: {
                            withAnimation {
                                streamData.isLoading = false
                            }
                        }))
                    }
                
                Text("")
                    .alert(isPresented: $model.showAlert) {
                        Alert(title: Text("Message"), message: Text(model.errorMsg), dismissButton:
                                    .destructive(Text("OK"),action: {
                            withAnimation {
                                model.isLoading = false
                            }
                        }))
                    }
            }
        )
        .overlay(
            
            ZStack{
                
//                New Channel View..
                if streamData.createNewChannel{
                    CreateNewChannelChatAppUsingStreamSDK()
                }
                
//                Loading Screen...
                if model.isLoading || streamData.isLoading{
                    LoadingScreenChatAppUsingStreamSDK()
                }
                                
            }
        )
        .environmentObject(streamData)
    }
}

struct ViewFirebasePhoneAuthFirebaseStreamSDK_Previews: PreviewProvider {
    static var previews: some View {
        ViewFirebasePhoneAuthFirebaseStreamSDK()
    }
}

var APIKeyFirebasePhoneAuthFirebaseStreamSDK = "ek8vrq4y2s8b"
var SecretKeyFirebasePhoneAuthFirebaseStreamSDK = "sxyha69u8mjgmqtydt46rx4n9b7578tpc497ktnwm45nuygx3h8nmz54daej2e99"
