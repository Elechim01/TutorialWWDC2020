//
//  iMessagePinnedView.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/09/21.
//

import SwiftUI

struct iMessagePinnedView: View {
    
    @State var messages : [MessageM] = [
        MessageM(id: 1, name: "n1", message: "ciao", profile: "g1", offset: 0),
        MessageM(id: 2, name: "n2", message: "ciao", profile: "g2", offset: 0),
        MessageM(id: 3, name: "n3", message: "ciao", profile: "g3", offset: 0),
        MessageM(id: 4, name: "n4", message: "ciao", profile: "g4", offset: 0),
        MessageM(id: 5, name: "n5", message: "ciao", profile: "g5", offset: 0),
        MessageM(id: 6, name: "n6", message: "ciao", profile: "g6", offset: 0),
        MessageM(id: 7, name: "n7", message: "ciao", profile: "g7", offset: 0),
        MessageM(id: 8, name: "n8", message: "ciao", profile: "g8", offset: 0)
    ]
    
    @State var pinnedViews : [MessageM] = []
    var columns = Array(repeating: GridItem(.flexible(),spacing: 15), count: 3)
    @Namespace var name
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            if !pinnedViews.isEmpty{
                //            Pinned View...
                LazyVGrid(columns: columns,spacing: 20) {
                    ForEach(pinnedViews){ pinned in
                        Image(pinned.profile)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        //                    padding 30 + spacng 20 = 70
                            .frame(width: (UIScreen.main.bounds.width - 70) / 3,
                                   height: (UIScreen.main.bounds.width - 70) / 3)
                            .clipShape(Circle())
//                        adding animation....
                            .matchedGeometryEffect(id: pinned.profile, in: name)
//                        context menu for restoring...
//                        context menushape...
                            .contentShape(Circle())
                            .contextMenu{
                                Button(action:{
//                                    Removing View...
                                    withAnimation(.default){
                                        var index = 0
                                        for i in 0..<pinnedViews.count{
                                            if pinned.profile == pinnedViews[i].profile{
                                                index = i
                                            }
                                        }
//                                        removing pin View...
                                        pinnedViews.remove(at: index)
//                                        adding view to main View...
                                        messages.append(pinned)
                                    }
                                } ,label:{
                                    Text("Remove")
                                })
                            }
                    }
                }
                .padding()
            }
            
            
            MessagePinnedview1()
        }
    }
    
    func getIndex(profile : String) -> Int{
        
        var index = 0
        
        for i in 0..<messages.count{
            if profile == messages[i].profile{
                index = i
            }
        }
        return index
    }
}


struct iMessagePinnedView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//sample data...
struct MessageM: Identifiable {
    var id: Int
    var name : String
    var message : String
    var profile : String
    var offset : CGFloat
}


struct MessagePinnedview1: View {
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(messages) { msg in
                ZStack {
                    
                    //                        adding Buttons...
                    HStack{
                        
                        Color.yellow
                            .frame(width: 90)
                        //                            hiding when left swipe...
                            .opacity(msg.offset > 0 ? 1 : 0)
                        
                        Spacer()
                        
                        Color.red
                            .frame(width: 90)
                            .opacity(msg.offset < 0 ? 1 : 0)
                    }
                    
                    
                    HStack{
                        Button {
                            
                            withAnimation {
                                
                                //                                appending View...
                                let index = getIndex(profile: msg.profile)
                                
                                var pinnedView = messages[index]
                                //                                setting offset to 0
                                pinnedView.offset = 0
                                
                                pinnedViews.append(pinnedView)
                                //                                removing from main View...
                                messages.removeAll { msg1 -> Bool in
                                    if msg.profile == msg1.profile{return true}
                                    else{return false}
                                }
                            }
                            
                        } label: {
                            Image(systemName: "pin.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(width: 90)
                        //                            on endded not working...
                        Spacer()
                        
                        Button {
                            withAnimation(.default){
                                //                                removing from main View...
                                messages.removeAll { msg1 -> Bool in
                                    if msg.profile == msg1.profile{return true}
                                    else{return false}
                                }
                            }
                        } label: {
                            Image(systemName: "trash.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(width: 90)
                        
                    }
                    
                    HStack(spacing: 15){
                        Image(msg.profile)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .matchedGeometryEffect(id: msg.profile, in: name)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(msg.name)
                            Text(msg.message)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                            
                            Divider()
                        }
                    }
                    .padding(.all)
                    .background(Color.white)
                    .contentShape(Rectangle())
                    //                    adding gesture...
                    .offset(x: msg.offset)
                    .gesture(DragGesture().onChanged({ value in
                        withAnimation(.default){
                            messages[getIndex(profile: msg.profile)].offset = value.translation.width
                        }
                        
                    }).onEnded({ value in
                        withAnimation(.default){
                            if value.translation.width > 80{
                                messages[getIndex(profile: msg.profile)].offset = 90
                            }else if value.translation.width < -80{
                                messages[getIndex(profile: msg.profile)].offset = -90
                            }else{
                                messages[getIndex(profile: msg.profile)].offset = 0
                            }
                        }
                    }))
                    
                }
            }
        }
        .padding(.vertical)
    }
}
