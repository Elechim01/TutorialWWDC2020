//
//  PostViewComposingFBComplexUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 11/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostViewComposingFBComplexUI: View {
    
    @State var post: Post
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            
            VStack{
                
                HStack(spacing: 15){
                    Image("p0")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text("Michele")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        Text(post.time)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image("menu")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 24, height: 24)
                    }

                }
                .padding()
                
                HStack{
                    
                    Text(post.title)
                        .foregroundColor(.black)
                    Spacer(minLength: 0)
                }
                .padding(.horizontal)
                
                Image(post.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 500)
                
                ZStack {
                    HStack{
                        
                        HStack(spacing: 10) {
                            if post.reaction == ""{
                                Image(systemName: "hand.thumbsup")
                                    .font(.system(size: 22, weight: .heavy))
                                    .foregroundColor(post.liked ? Color.blue : .gray)
                        }
                            Text(post.reaction == "" ?  (post.liked ? "Liked" : "Like") : "")
                                .fontWeight(.heavy)
                                .foregroundColor(post.liked ? Color.blue : .gray)
                            
                            AnimatedImage(name: post.reaction)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                        }
                        .onTapGesture {
                            post.liked.toggle()
                        }
//                        Drag gesture...
                        .gesture(DragGesture(minimumDistance: 0)
                                    .onChanged(onChanged(value:))
                                    .onEnded(onEnded(value:)))
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            
                        } label: {
                            Label {
                                Text("Share")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.gray)
                            } icon: {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 22, weight: .heavy))
                                    .foregroundColor(.gray)
                            }

                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Label {
                            Text("Comment")
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                        } icon: {
                            Image(systemName: "message")
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                
            }
            .zIndex(0)
            
            if post.show{
                ReactionViewComposingFBComplexUI(post: $post)
                    .offset(y: -80)
                    .padding(.leading)
                    .zIndex(1)
            }
        }
    }
    
    
    
    func onChanged(value: DragGesture.Value){
        withAnimation(.easeIn){
            post.show = true
        }
        
//        Simple Logic...
        
        withAnimation(Animation.linear(duration: 0.15)){
        
        let x = value.location.x
        
        if x > 20 && x < 80{post.reaction = reactions[0]}
        if x > 80 && x < 140{post.reaction = reactions[1]}
        if x > 140 && x < 180{post.reaction = reactions[2]}
        if x > 180 && x < 240{post.reaction = reactions[3]}
        if x > 240 && x < 300{post.reaction = reactions[4]}
        if x > 300 && x < 360{post.reaction = reactions[5]}
        
//        if less or exceeds no Reaction....
        if x < 20 || x > 360{post.reaction = ""}
        }
    }
    func onEnded(value: DragGesture.Value){
        withAnimation(Animation.linear.delay(0.3)){
            post.show = false
        }
    }
}
struct PostViewComposingFBComplexUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewComposingFBComplexUI()
    }
}

