//
//  HomeDepthStacksGestures.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/09/21.
//

import SwiftUI

struct HomeDepthStacksGestures: View {
    
    @State var profiles = [
        Profile(id: 0, name: "immagine1", image: "p1", age: "40000", offset: 0),
        Profile(id: 1, name: "immagine2", image: "p2", age: "40000", offset: 0),
        Profile(id: 2, name: "immagine3", image: "p3", age: "40000", offset: 0),
        Profile(id: 3, name: "immagine4", image: "p4", age: "40000", offset: 0),
        Profile(id: 4, name: "immagine5", image: "p5", age: "40000", offset: 0),
        Profile(id: 5, name: "immagine6", image: "p6", age: "40000", offset: 0),
        Profile(id: 6, name: "immagine7", image: "p7", age: "40000", offset: 0),
    ]
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                
                Button(action: {}, label: {
                    Image("menu")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                })
                
                Text("Blind Dating")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Button(action: {}, label: {
                    Image("noti")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                })
            }
            .foregroundColor(.black)
            .padding()
            
//            for reading height and with...
                
            GeometryReader{ g in
                ZStack{
//                    Zstack will overlay one on another so reversing the array to display the first and last properly...
                    ForEach(profiles.reversed()){ profile in
                        
//                        profile View...
                        ProfileView(profile: profile, frame: g.frame(in: .global))
                    }
                }
            }
            .padding([.horizontal,.bottom])
            
            Spacer(minLength: 0)
            
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
    }
}

struct HomeDepthStacksGestures_Previews: PreviewProvider {
    static var previews: some View {
        HomeDepthStacksGestures()
    }
}

struct ProfileView : View {
    @State var profile : Profile
    var frame : CGRect
    var body: some View{
        
//      setting information view to bottom...
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            Image(profile.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frame.width, height: frame.height)
//          adding color when its accepted or rejected...
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                (profile.offset > 0 ? Color.green : Color("Color"))
                    .opacity(profile.offset != 0 ? 0.7 : 0)
                
//                  Text...
                HStack{
                    
                    if profile.offset < 0 {
                        Spacer(minLength: 0)
                    }
                    
                    Text(profile.offset == 0 ? "" : (profile.offset > 0 ? "Liked" : "Rejected"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top,25)
                        .padding(.horizontal)
                    
                    if profile.offset > 0 {
                        Spacer(minLength: 0)
                    }
                    
                }
                
            })
            
//            Slightly Dark shade to bottom....
            LinearGradient(gradient: .init(colors: [Color.black.opacity(0),Color.black.opacity(0.4)]), startPoint: .center, endPoint: .bottom)
            
//              Displayng Information...
            
            VStack(spacing: 15) {
                HStack{
                    VStack(alignment: .leading, spacing: 12, content: {
                        Text(profile.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(profile.age + "+")
                            .fontWeight(.bold)
                    })
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                }
                
//              Buttons...
                HStack(spacing: 35){
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        withAnimation(Animation.easeIn(duration: 0.8)){
//                            moving view left...
                            profile.offset = -500
                        }
                        
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color("Color"))
                            .clipShape(Circle())
                    })
                    
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.8)){
//                            moving view right...
                            profile.offset = 500
                        }
                    }, label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.green)
                            .clipShape(Circle())
                    })
                    
                    Spacer(minLength: 0)
                    
                }
            }
            .padding()
        }
        .cornerRadius(20)
        .offset(x: profile.offset)
//        rotating view when its disappearing...
        .rotationEffect(.init(degrees: profile.offset == 0 ? 0 : (profile.offset > 0 ? 12 : -12)))
        
//        adding drag gesture...
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation(.default){
                        profile.offset = value.translation.width
                    }
                })
                .onChanged({ value in
                    withAnimation(Animation.easeIn){
                        if profile.offset > 150{
                            profile.offset = 500
                        }else if profile.offset < -150{
                            profile.offset = -500
                        }else{
                            profile.offset = 0
                        }
                    }
                })
        )
    }
}


//sample Data...
struct Profile: Identifiable {
    var id : Int
    var name : String
    var image : String
    var age : String
    var offset : CGFloat
}


