//
//  ViewSlideOutMenu.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 12/10/21.
//

import SwiftUI

struct ViewSlideOutMenu: View {
    
//    for future use....
    @State var width = UIScreen.main.bounds.width - 90
//    to hide view...
    @State var x = -UIScreen.main.bounds.width + 90
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            HomePageSlideView(x: $x)
            
            
                SlideMenu()
                .shadow(color: Color.black.opacity(x != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: x)
                .background(Color.black.opacity(x == 0 ? 0.5 : 0).ignoresSafeArea(.all, edges: .vertical).onTapGesture(perform: {
//                    hiding view when back is pressed...
                    withAnimation {
                        x = -width
                    }
                }))
            }
//        adding gesture or drag feature...
        .gesture(DragGesture().onChanged({ value in
            
            withAnimation {
                
                if value.translation.width > 0{
                    if x < 0{
                        x = -width + value.translation.width
                    }
                    
                }else{
                    x = value.translation.width
                }
            }
        }).onEnded({ value in
            withAnimation {
                
//              cheking if half the value of menu is dragged menas settings x to 0...
                if -x < width / 2{
                    x = 0
                }else{
                    x = -width
                }
             
            }
        }))
        }
    }


struct ViewSlideOutMenu_Previews: PreviewProvider {
    static var previews: some View {
        ViewSlideOutMenu()
    }
}


struct HomePageSlideView: View {
    
    @Binding var x : CGFloat
    
    var body: some View{
//        Home View Width Custom Nav Bar...
        VStack{
            HStack{
                Button {
                    
//                  opening menu,...
                    withAnimation {
                        x = 0
                    }
                    
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 24))
                        .foregroundColor(Color.blue)
                }
                
                Spacer(minLength: 0)
                
                Text("Twitter")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            Spacer()
        }
//        for drag gesture...
        .contentShape(Rectangle())
        .background(Color.white)
    }
}

struct SlideMenu: View {
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var show = true
    
    var body: some View{
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Image("g1")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                HStack(alignment: .top, spacing: 12) {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Michele")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("@_KAvasoft")
                            .foregroundColor(.gray)
                        
    //                    Floww Counts..
                        HStack(spacing: 20) {
                            FollowView(count: 8, title: "Following")
                                .onTapGesture {
                                    
                                }
                            
                            FollowView(count: 108, title: "Following")
                                .onTapGesture {
    //                                do somethin here...
                                }
                        }
                        .padding(.top,10)
                        
                        Divider()
                            .padding(.top,10)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        withAnimation {
                            show.toggle()
                        }
                    } label: {
                        Image(systemName: show ? "chevron.down" : "chevron.up")
                            .foregroundColor(Color.blue)
                    }

                }
                
//                Dfferent Views When up or down buttons presed....
                
                VStack(alignment: .leading) {
//                    Menu Buttons....
                    ForEach(menuButtons,id: \.self){ menu in
                        
                        Button {
//                            switch your actions or work based on title...
                            
                        } label: {
                            MenuButton(title: menu)
                        }

                       
                    }
                    
                    Divider()
                        .padding(.top)
                    
                    Button {
                        
                    } label: {
                        MenuButton(title: "Twitter Ads")
                    }
                    
                    Divider()
                    
                    Button {
                        
                    } label: {
                        Text("Settings and privacy")
                            .foregroundColor(.black)
                    }
                    .padding(.top)
                    
                    Button {
                        
                    } label: {
                        Text("Help centre")
                            .foregroundColor(.black)
                    }
                    .padding(.top,20)
                    
                    Spacer(minLength: 0)
                    
                    Divider()
                        .padding(.bottom)
                    
                    HStack{
                        Button {
                            
                        } label: {
                            Image("help")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color.blue)
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            
                        } label: {
                            Image("barcode")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color.blue)
                        }
                    }
                }
//              hiding this view when down arrow pressed...
                .opacity(show ? 1 : 0)
                .frame(height: show ? nil : 0)
                
//                Alternative View For Up Arrow...
                VStack(alignment: .leading) {
                    Button {
                        
                    } label: {
                        Text("Create a new account")
                            .foregroundColor(Color.blue)
                    }
                    .padding(.bottom)
                    
                    Button {
                        
                    } label: {
                        Text("Add an exisitng account")
                            .foregroundColor(Color.blue)
                    }
                    
                    Spacer(minLength: 0)
                }
                .opacity(show ? 0 : 1)
                .frame(height: show ? 0 : nil)
                
            }
            .padding(.horizontal,20)
//            since vertical edges are ignored...
            .padding(.top,edges!.top == 0 ? 15 : edges!.top)
            .padding(.bottom,edges!.bottom == 0 ? 15 : edges!.bottom)
    //        default width...
            .frame(width: UIScreen.main.bounds.width - 90)
            .background(Color.white)
            .ignoresSafeArea(.all, edges: .vertical)
          
        }
        .background(Color.black.opacity(0.5).ignoresSafeArea(.all, edges: .vertical))
    }
}

struct FollowView: View {
    
    var count : Int
    var title : String
    
    var body: some View{
        HStack{
            Text("\(count)")
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(title)
                .foregroundColor(.gray)
        }
    }
}

var menuButtons = ["Account","menu","noti","Explore","steps"]

struct MenuButton: View {
    var title : String
    
    var body: some View{
        
        HStack(spacing: 15){
            
//            both title and image names are same...
            Image(title)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
            
            Text(title)
                .foregroundColor(.black)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical,12)
    }
}
