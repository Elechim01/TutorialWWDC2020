//
//  ChannelViewChatAppusingStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI
import StreamChat
import Firebase

struct ChannelViewChatAppusingStreamSDK: View {
    
    @EnvironmentObject var streamData: StreamViewModelChatAppUsingStreamSDK
    
    @AppStorage("userName") var storedUser = ""
    @AppStorage("log_Status") var logStatus = false
    
    var body: some View {
        //                Channel View..
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 20){
                
                if let channels = streamData.channels{
                    
                    ForEach(channels,id:\.channel){ listener in
                        
                        NavigationLink {
                            ChatViewChatAppUsingStreamSDK(listener: listener)
                        } label: {
                            ChannelRowViewChatAppUsingStreamSDK(listner: listener)
                        }

                    }
                    
                }else{
                    //                            progress View...
                    ProgressView()
                        .padding(.top,20)
                }
            }
            .padding()
        }
        .navigationTitle("Channel")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    streamData.channels = nil
                    streamData.fetchAllChanels()
                } label: {
                    Image(systemName: "arrow.clockwise.circle.fill")
                }
                
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation {
                        streamData.createNewChannel.toggle()
                    }
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
            
//            Disabilitare per FirebasePhoneAuthFirebaseStreamSDK
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
//                    Logging Out...
                    logStatus = false
                    storedUser = ""
                    try! Auth.auth().signOut()
                    
                } label: {
                    Image(systemName: "power")
                }
            }
            
        }
        .onAppear {
            streamData.fetchAllChanels()
        }
    }
}

struct ChannelViewChatAppusingStreamSDK_Previews: PreviewProvider {
    static var previews: some View {
        ChannelViewChatAppusingStreamSDK()
    }
}
// Channel Row View...
struct ChannelRowViewChatAppUsingStreamSDK: View{
    
    @StateObject var listner: ChatChannelController.ObservableObject
    
    @EnvironmentObject var streamData: StreamViewModelChatAppUsingStreamSDK
    
    var body: some View{
        
        VStack(alignment: .trailing, spacing: 5) {
            
            HStack(spacing: 12){
                
                let channel = listner.controller.channel!
                
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 55, height: 55)
                    .overlay(
                        //                    First Letter as Image..
                        Text("\(String(channel.cid.id.first!))")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        
                    )
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(channel.cid.id)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    //                        Last Msg....
                    if let lastMsg = channel.latestMessages.first{
//                       Showing the last user name...
                        (
                            Text(lastMsg.isSentByCurrentUser ? "Me: " : "\(lastMsg.author.id):  ")
                            
                            +
                            
                            Text(lastMsg.text)
                        )
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
                
                Spacer(minLength: 10)
                
//                Time...
                if let time = channel.latestMessages.first?.createdAt{
                    
                    Text(time,style: checkIsDateToday(date: time) ? .time : .date)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .padding(.leading,60)
        }
        .onAppear {
//            watched the updates on channel..
            listner.controller.synchronize()
        }
        .onChange(of: listner.controller.channel?.latestMessages.first?.text) { newValue in
//            firing sort..
            print("sort channels...")
            sortChannels()
        }
    }
    
//    checking if msg is from today then dispay time else display date..
    func checkIsDateToday(date: Date)->Bool{
        
        let calender = Calendar.current
        
        if calender.isDateInToday(date){
            return true
        }else{
            return false
        }
    }
    
    func sortChannels(){
        
        let result = streamData.channels.sorted { ch1, ch2 in
            
            if let date1 = ch1.channel?.latestMessages.first?.createdAt{
                if let date2 = ch2.channel?.latestMessages.first?.createdAt{
                    return date1 > date2
                    
                }else{
                    return false
                }
            }else{
                return false
            }
        }
        
        streamData.channels = result
        
    }
    
}
