//
//  ChatViewChatAppUsingStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI
import StreamChat

struct ChatViewChatAppUsingStreamSDK: View {
    
    @StateObject var listener: ChatChannelController.ObservableObject
    
    @State var message = ""
    
//    Color Scheme
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        
        let channel = listener.controller.channel!
        
        VStack{
            
//         scrollView Reader fo scrolling down..
            ScrollViewReader{ reader in
                ScrollView(.vertical, showsIndicators: false) {
    //                Lazy Stack For Lazy Loading...
                    LazyVStack(alignment: .center, spacing: 15) {
                        
                        ForEach(listener.messages.reversed(),id:\.self){ msg in
                            
    //                        Message Row...
                            MessageRowViewChatAppUsingStreamSDK(message: msg)
                        }
                    }
                    .padding()
                    .padding(.bottom,10)
                    .id("MSG_VIEW")
                }
                .onChange(of: listener.messages, perform: { newValue in
                    withAnimation {
                        reader.scrollTo("MSG_VIEW", anchor: .bottom)
                    }
                })
                .onAppear{
//                    Scrolling to bottom...
                    reader.scrollTo("MSG_VIEW", anchor: .bottom)
                }
            }
            
//            Textfield And Send Button...
            HStack(spacing: 10){
                TextField("Message",text: $message)
                    .modifier(ShadowModifierChatAppUsingStreamSDK())
                
                Button {
                    sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .padding(10)
                        .background(Color.primary)
                        .foregroundColor(scheme == .dark ? .black : .white)
                        .clipShape(Circle())
                }
//                Disabling Button when no tst typed...
                .disabled(message == "")
                .opacity(message == "" ? 0.5 : 1)
            }
            .padding(.horizontal)
            .padding(.bottom,8)
            
        }
        .navigationTitle(channel.cid.id)
    }
    
//    sending Message..
    func sendMessage(){
        
//        since we create a channel for messaging...
        
        let channelID = ChannelId(type: .messaging, id: listener.channel?.cid.id ?? "")
        
        ChatClient.shared.channelController(for: channelID).createNewMessage(text: message){ result in
            
            switch result {
            case .success(let id):
                print("success = \(id)")
            case .failure(let error):
//                show error..
                print(error.localizedDescription)
        }
    }
//        clearing MSg Field...

        message = ""
    }
}

struct ChatViewChatAppUsingStreamSDK_Previews: PreviewProvider {
    static var previews: some View {
        ViewChatAppUsingStreamSDK()
    }
}


