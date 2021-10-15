//
//  HomeParallaxScrolling.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/09/21.
//

import SwiftUI

struct HomeParallaxScrolling: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader{ reader in
                if reader.frame(in: .global).minY > -480 {
                    Image("p0")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
    //                Type 2....
                    
    //                moving View Up...
                        .offset(y: -reader.frame(in: .global).minY)
    //                going to add parallx effect....
                        .frame(width: UIScreen.main.bounds.width,
                           height: reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 480 : 480 )
                }
            }
//            default frame...
            .frame(height: 480)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Montagna ")
                    .font(.system(size: 35,weight: .bold))
                    .foregroundColor(.white)
                HStack(spacing: 15){
                    ForEach(1...5, id: \.self){_ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                    }
                }
                Text("Some Scene may Very Young Childrens")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.top,5)
                Text(plot)
                    .padding(.top,10)
                    .foregroundColor(.white)
                
                HStack(spacing: 15){
                    Button {
                        
                    } label: {
                        Text("Bookmark")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal,20)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Buy Tickes")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal,20)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding(.top,25)
            }
            .padding(.top,25)
            .padding(.horizontal)
            .background(Color.black)
            .cornerRadius(20)
            .offset(y: -35)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct HomeParallaxScrolling_Previews: PreviewProvider {
    static var previews: some View {
        HomeParallaxScrolling()
    }
}
var plot = "Developing for Apple platforms puts the cutting-edge technology of iOS, iPadOS, macOS, tvOS, and watchOS at your fingertips, giving you limitless ways to bring incredible apps to users around the world. These powerful platforms each offer unique capabilities and user experiences, yet integrate tightly to form a true ecosystem. Hardware, software, and services are designed from the ground up to work together so you can build intuitive, multi-faceted experiences that are genuinely seamless.\nWhether you’re a first-time coder or an experienced developer looking to integrate the latest Apple technologies into your app, take advantage of free online resources to learn how to create apps with Swift and a variety of events and programs around the world."
