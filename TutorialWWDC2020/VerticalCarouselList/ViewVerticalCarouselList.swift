//
//  ViewVerticalCarouselList.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 11/10/21.
//

import SwiftUI
import AVKit

struct ViewVerticalCarouselList: View {
    
    var body: some View {
        NavigationView{
            HomeVerticalCarousel()
                .preferredColorScheme(.dark)
                .navigationTitle("")
                .navigationBarHidden(true)
        }
    }
}

struct ViewVerticalCarouselList_Previews: PreviewProvider {
    static var previews: some View {
        ViewVerticalCarouselList()
    }
}

struct HomeVerticalCarousel: View {
    @State var index = 0
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
//    creating sample video array...
    @State var videos = [
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_2MB.mp4")!),
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_2MB.mp4")!),
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_2MB.mp4")!),
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_2MB.mp4")!),
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_2MB.mp4")!)
        
    ]
    
    var body: some View{
        TabView(selection: $index) {
            ForEach(0..<videos.count,id: \.self){ i in
               
//                simple vertical tab bar...
//                cross verification...
                Player(video: $videos[i])
                .padding()
                .rotationEffect(.init(degrees: -90))
//                settings width...
                .frame(width: UIScreen.main.bounds.width)
//                to find current index...
//                setting tag for each video...
                .tag(i)
            }
//            whenever index changes..
//            ie tab changes... pausing all other videos and playing current one...
            .onChange(of: index) { _ in
                for i in 0..<videos.count{
                    videos[i].pause()
                }
                
//                Playing current video
                videos[index].play()
            }
            
        }
        .rotationEffect(.init(degrees: 90))
//        if view is rotated means width will be equal to height...
//        removing edges values...
        .frame(width: UIScreen.main.bounds.height - (edges!.top + edges!.bottom))
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.black.ignoresSafeArea(.all, edges: .all))
        
//        simple Logic..
//        rotating views and changing width and height.....
        
    }
}

// buildeing tiktok Video Player...
struct Player : View {
    
    @Binding var video : AVPlayer
    
    var body: some View{
        VideoPlayer(player: video)
    }
}
