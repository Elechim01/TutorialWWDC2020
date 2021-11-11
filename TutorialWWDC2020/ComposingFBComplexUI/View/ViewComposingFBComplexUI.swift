//
//  ViewComposingFBComplexUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 10/11/21.
//

import SwiftUI

struct ViewComposingFBComplexUI: View {
    var body: some View {
        HomeViewComposingFBComplexUI()
    }
}

struct ViewComposingFBComplexUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewComposingFBComplexUI()
    }
}
struct HomeViewComposingFBComplexUI: View {
    
//    Model Data...
    @State var posts = [
        Post(image: "p2", title: "prova1", time: "5:15pm", liked: false, reaction: ""),
        Post(image: "p3", title: "prova2", time: "6:15pm", liked: true, reaction: ""),
        Post(image: "p4", title: "prova3", time: "7:15pm", liked: true, reaction: ""),
        Post(image: "p5", title: "prova4", time: "8:15pm", liked: false, reaction: ""),
    ]
    
    var body: some View{
        ZStack{
            Color.blue.ignoresSafeArea(.all, edges: .top)
            Color.white.ignoresSafeArea(.all, edges: .bottom)
            
            VStack(spacing: 0) {
                
                HStack(spacing: 12){
                        Text("facebook")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "message.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                    }

                }
                .padding()
                .background(Color.blue)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 12){
                        ForEach(posts){ post in
//                            Post View...
                            PostViewComposingFBComplexUI(post: post)
                                .background(Color.white)
                        }
                    }
                }
            }
        }
    }
}
