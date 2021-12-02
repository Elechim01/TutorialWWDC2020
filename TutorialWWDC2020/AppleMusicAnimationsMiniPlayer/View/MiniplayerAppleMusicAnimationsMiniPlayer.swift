//
//  MiniplayerAppleMusicAnimationsMiniPlayer.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 02/12/21.
//

import SwiftUI

struct MiniplayerAppleMusicAnimationsMiniPlayer: View {
    var body: some View {
        VStack{
            HStack(spacing: 15){
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .cornerRadius(15)
                
                Text("Lady Gaga")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image(systemName: "play.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                }

            }
            .padding(.horizontal)
        }
        .frame(height: 80)
//            moving the miniplayer above the tabbar...
//            assproz tab bar height is 49..
        
//        Dvider Line For Separating Miniplayer And Tab Bar...
        .background(
            VStack(spacing: 0){
                BlurViewAppleMusicAnimationsMiniPlayer()
                
                Divider()
            }
        )
        .offset(y: -48)
    }
}


