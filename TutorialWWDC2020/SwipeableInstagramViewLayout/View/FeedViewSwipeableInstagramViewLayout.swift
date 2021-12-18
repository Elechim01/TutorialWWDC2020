//
//  FeedViewSwipeableInstagramViewLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct FeedViewSwipeableInstagramViewLayout: View {
    
    @Binding var offset: CGFloat
    
    var body: some View {
        VStack{
            
            HStack{
                Button {
                    
                } label: {
                    Image(systemName: "plus.app")
                        .font(.title)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Button {
                    offset = rectSwipeableInstagramViewLayout.width * 2
                } label: {
                    Image(systemName: "paperplane")
                        .font(.title)
                        .foregroundColor(.primary)
                }

            }
            .padding()
            .overlay(
                Text("Instagram")
                    .font(.title2)
                    .fontWeight(.bold)
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 15){
                       
                        Button(action: {
                            
                        }, label: {
                            Image("p1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                        })
                            .overlay(
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.blue)
                                    .background(Color.white.clipShape(Circle()))
                                    .offset(x: 8, y: 5)
                                
                                ,alignment: .bottomTrailing
                            )
                    }
                    .padding()
                }
                Divider()
                    .padding(.horizontal,-15)
                
                VStack(spacing: 0){
//                    Posts...
                    ForEach(postSwipeableInstagramViewLayout){ post in
                        
//                        Post View...
                        PostCardViewSwipeableInstagramViewLayout(post: post)
                    }
                }
                .padding(.bottom,65)
            }
        }
    }
}



struct PostCardViewSwipeableInstagramViewLayout: View {
    
    var post: PostSwipeableInstagramViewLayout
    @State var comment = ""
    
    var body: some View{
        
        VStack(spacing: 15){
            
            HStack(spacing: 15){
                Image(post.profile)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                
                Text(post.user)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.primary)
                }
            }
            
            Image(post.postImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: rectSwipeableInstagramViewLayout.width - 30, height: 300)
                .cornerRadius(15)
            
            HStack(spacing: 15){
                Button {
                    
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 25))
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .font(.system(size: 25))
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                        .font(.system(size: 25))
                }
            }
            .foregroundColor(.primary)
            (
//                binding Two Texts...
                
                Text("\(post.user) ")
                    .fontWeight(.bold)
                
                +
                Text(post.postTitle)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(6)
            
            HStack(spacing: 15){
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                TextField("Add a comment",text: $comment)
            }
           
            Text(post.time)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(6)
            
        }
        .padding()
    }
}
