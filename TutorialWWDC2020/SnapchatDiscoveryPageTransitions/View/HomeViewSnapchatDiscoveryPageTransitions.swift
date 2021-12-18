//
//  HomeViewSnapchatDiscoveryPageTransitions.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

struct HomeViewSnapchatDiscoveryPageTransitions: View {
    
//    For Getting Dark Mode Or Light...
    @Environment(\.colorScheme) var scheme
    
//    Columns...
    let columns = Array(repeating: GridItem(.flexible(),spacing: 8), count: 2)
    
//    Animation NameSpace...
    @Namespace var animation
    
    @StateObject var playerModel = VideoPlayerViewModelSnapchatDiscoveryPageTransitions()
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0){
                
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.pink)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 22))
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 22))
                            .foregroundColor(.primary)
                    }

                }
                .padding(.horizontal)
                .padding(.vertical,10)
                .overlay(
                    Text("Discover")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                )
    //            shadow..
                .background(scheme == .dark ? Color.black : Color.white)
                .shadow(color: Color.primary.opacity(0.08), radius: 5, x: 0, y: 5)
                
                ScrollView{
                    
                    LazyVGrid(columns: columns) {
                        ForEach(videosSnapchatDiscoveryPageTransitions){ video in
                            VideoPlayerViewSnapchatDiscoveryPageTransitions(player: video.player)
                                .cornerRadius(15)
                                .matchedGeometryEffect(id: video.id, in: animation)
                                .scaleEffect(playerModel.shoPlayer && playerModel.selectedVideo.id == video.id ? playerModel.scale : 1)
//                            Horizontal Spacing And spacing Between items..
                                .frame(width: (UIScreen.main.bounds.width - 45) / 2,height: 28)
                                .onTapGesture {
                                    withAnimation {
                                        playerModel.selectedVideo = video
                                        playerModel.shoPlayer = true
                                    }
                                }
                                .zIndex(0)
                        }
                    }
                    .padding()
                    
                }
            }
            
            if playerModel.shoPlayer{
                VideoPlayerViewSnapchatDiscoveryPageTransitions(player: playerModel.selectedVideo.player)
                    .cornerRadius(15)
                    .scaleEffect(playerModel.scale)
                    .matchedGeometryEffect(id: playerModel.selectedVideo.id, in: animation)
                    .offset(playerModel.offset)
                    .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
//        Playing video When Opens...
                    .onAppear{
                        playerModel.selectedVideo.player.play()
                    }
                    .ignoresSafeArea(.all,edges: .all)
                    .zIndex(3)
//                Dragging...
            }
        }
    }
    
    func onChanged(value: DragGesture.Value){
        
//       Only Moving View When Swipes Down...
        if value.translation.height > 0 {
            playerModel.offset = value.translation
            
//            Scaling View...
            
            let screenHeight = UIScreen.main.bounds.height - 50
            
            let progress = playerModel.offset.height / screenHeight
            
//            only if > 0.5
            if 1 - progress > 0.5{
            
                playerModel.scale = 1 - progress
            
            }
            
        }
    }
    
    func onEnd(value: DragGesture.Value){
//        Resetting view...
        withAnimation(.default){
            
    //            cheking And closing View...
            if value.translation.height > 300{
//                Stop Playing video...
                playerModel.selectedVideo.player.pause()
                playerModel.shoPlayer = false
            }
            
            playerModel.offset = .zero
            playerModel.scale = 1
        
        }
    }
    
}

struct HomeViewSnapchatDiscoveryPageTransitions_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSnapchatDiscoveryPageTransitions()
    }
}
