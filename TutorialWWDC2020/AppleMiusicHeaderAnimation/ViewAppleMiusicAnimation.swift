//
//  ViewAppleMiusicAnimation.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/10/21.
//

import SwiftUI

struct ViewAppleMiusicAnimation: View {
    
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
//                    First Parallax Scroll...
                    Image("p0")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
//                    List Of Songs...
                    VStack(spacing: 10){
                        ForEach(albums,id: \.album_name){ album in
                            
                            HStack(spacing: 15){
                                Image("\(album.album_cover)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 55, height: 55)
                                    .cornerRadius(15)
                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    Text("\(album.album_name)")
                                    
                                    Text("\(album.album_author)")
                                        .font(.caption)
                                }
                                Spacer(minLength: 0)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            
            HStack{
                Button {
                    
                } label: {
                    HStack(spacing: 8){
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .bold))
                        
                        Text("Search")
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image("menu")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 22, height: 22)
                            .rotationEffect(.init(degrees: 90))
                    }

                }

            }
            .padding()
            .foregroundColor(.white)
//          since top eges is ignored...
            .padding(.top,edges!.top)
            .background(Color.white.opacity(0))
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct ViewAppleMiusicAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ViewAppleMiusicAnimation()
    }
}

//sample data...
struct Album{
    var album_name : String
    var album_author : String
    var album_cover : String
}
var albums = [
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p1"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p2"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p3"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p4"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p5"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p1"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p2"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p3"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p4"),
    Album(album_name: "prova1", album_author: "autore1", album_cover: "p5")
]
