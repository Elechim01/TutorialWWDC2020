//
//  StreamViewModelChatAppUsingStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI
import StreamChat

class StreamViewModelChatAppUsingStreamSDK: ObservableObject {
  
    @Published var userName = ""
    
    @AppStorage("userName") var sotoredUser = ""
    @AppStorage("log_Status") var logStatus = false
    
//    Alert...
    @Published var error = false
    @Published var errorMsg = ""
    
//    Loading Screen...
    @Published var isLoading = false
    
//    Channel Data...
    @Published var channels: [ChatChannelController.ObservableObject]!
    
//    Create New Channel..
    @Published var createNewChannel = false
    @Published var channelName = ""
    
    
    func logInUser(){
//        Logging In User...
        
        withAnimation {
            isLoading = true
        }
     
//        Da disabilitare per ChatAppUsingStreamSDK
//        Updating User Profile...
//        you can give user image url if want...
        
//         Da scommentare per App che richiedono StreamChat
//        ChatClient.shared.currentUserController().updateUserData(name: userName, imageURL: nil, userExtraData: .defaultValue) { err in
//            withAnimation {
//                self.isLoading = false
//            }
//
//
//            if let  error = err{
//                self.errorMsg = error.localizedDescription
//                self.error.toggle()
//                return
//            }
//            //            Else Successfull...
//            //            storing userName..
//            self.sotoredUser = self.userName
//            self.logStatus = true
//        }
        
//        Disabilitato per FirebasePhoneAuthFirebaseStreamSDK
//        let config = ChatClientConfig(apiKeyString: APIKeyChatAppUsingStreamSDK)
//        ChatClient.shared = ChatClient(config: config, tokenProvider: .development(userId: userName))
//
//        ChatClient.shared.currentUserController().reloadUserIfNeeded { err in
//
//            withAnimation {
//                self.isLoading = false
//            }
//
//
//            if let  error = err{
//                self.errorMsg = error.localizedDescription
//                self.error.toggle()
//                return
//            }
////            Else Successfull...
////            storing userName..
//            self.sotoredUser = self.userName
//            self.logStatus = true
//        }
    }
    
//    Fetching All Channels...
    func fetchAllChanels(){
        
        if channels == nil{
            
//            fillter...
            let filter = Filter<ChannelListFilterScope>.equal("type", to: "messaging")
            
            let request = ChatClient.shared.channelListController(query: .init(filter: filter))
            
            request.synchronize { err in
                if let error = err{
                    self.errorMsg = error.localizedDescription
                    self.error.toggle()
                    return
                }
                
//                else Successful..
                self.channels = request.channels.compactMap({ channel -> ChatChannelController.ObservableObject? in
                    return ChatClient.shared.channelController(for: channel.cid).observableObject
                })
                
            }
        }
    }
    
//    Creating New Channel...
    func createChannel(){
    
        withAnimation {
            self.isLoading = true
        }
        
        let newChannel = ChannelId(type: .messaging, id: channelName)
        
//        you can give image url to channel...
//        same you can also give image url to user..
//        Da disabilitare per chat App 
//        let request = try! ChatClient.shared.channelController(createChannelWithId: newChannel, name: channelName, imageURL: nil, extraData: .defaultValue)
        
//        request.synchronize { err in
//
//            withAnimation {
//                self.isLoading = false
//            }
//
//            if let error = err{
//                self.errorMsg = error.localizedDescription
//                self.error.toggle()
//                return
//            }
//
////            Success....
////            closing Loading And New Channel View..
//            withAnimation {
//                self.channelName = ""
//                self.createNewChannel = false
//            }
//        }
        
    }
    
    
}

