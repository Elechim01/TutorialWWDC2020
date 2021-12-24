//
//  MessageRowViewChatAppUsingStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI
import StreamChat

struct MessageRowViewChatAppUsingStreamSDK:View {
    
    var message: ChatMessage
    
    var body: some View{
        HStack{
            if message.isSentByCurrentUser{
                Spacer()
            }
            
//            Msg width Chat Bubble...
            HStack(alignment: .bottom,spacing: 10){
                
                if !message.isSentByCurrentUser{
                    UserViewChatAppUsingStreamSDK(message: message)
                        .offset(y: 10)
                }
                
                VStack(alignment: message.isSentByCurrentUser ? .trailing : .leading, spacing: 6) {
                    
                    Text(message.text)
                    
                    Text(message.createdAt,style: .time)
                        .font(.caption)
                }
                .padding([.horizontal,.top])
                .padding(.bottom,8)
    //            Current User color is blue and opposite uset color is gray..
                .background(message.isSentByCurrentUser ? Color.blue : Color.gray.opacity(0.4))
                .clipShape(ChatBubbleChatAppUsingStreamSDK(corners: message.isSentByCurrentUser ? [.topLeft,.topRight,.bottomLeft] : [.topLeft,.topRight,.bottomRight]))
                .foregroundColor(message.isSentByCurrentUser ? .white : .primary)
                .frame(width: UIScreen.main.bounds.width - 150, alignment: message.isSentByCurrentUser ? .trailing : .leading)
                
                if message.isSentByCurrentUser{
                    UserViewChatAppUsingStreamSDK(message: message)
                        .offset(y: 10)
                }
                
            }
            
            if !message.isSentByCurrentUser{
                Spacer()
            }
        }
    }
}

struct MessageRowViewChatAppUsingStreamSDK_Previews: PreviewProvider {
    static var previews: some View {
      ViewChatAppUsingStreamSDK()
    }
}

//user View...
struct UserViewChatAppUsingStreamSDK: View {
   
    var message: ChatMessage
    var body: some View{
        
        Circle()
            .fill(message.isSentByCurrentUser ? Color.blue : Color.gray.opacity(0.4))
            .frame(width: 40, height: 40)
            .overlay(
//            Author First letter...
                Text("\(String(message.author.id.first!))")
                    .fontWeight(.semibold)
                    .foregroundColor(message.isSentByCurrentUser ? .white : .primary)
            )
//            Context Menu For Showing User Name And Last Active Status...
            .contextMenu {
                
                Text("\(message.author.id)")
                
                if message.author.isOnline{
                    Text("Status: Online")
                }else{
                    Text(message.author.lastActiveAt ?? Date(),style: .time)
                }
                
            }
        
    }
}
