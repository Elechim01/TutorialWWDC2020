//
//  ViewHeroAnimation.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 20/09/21.
//

import SwiftUI

struct ViewHeroAnimation: View {
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    @State var selected : Travel = dataT[0]
    @State var show = false
    @Namespace var namespace
//    to load Hero View After Animation is done....
    @State var loadView  = false
    
    var body: some View {
        ZStack{
            
            ScrollView(.vertical, showsIndicators: false){
                HStack{
                    Text("Travel")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image("menu")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 40, height: 40)
                    })
                }
    //            due top area is ignored..
                .padding([.horizontal,.top])
                
//                Grid View..
                LazyVGrid(columns: columns,spacing: 25){
                    ForEach(dataT){ travel in
                        VStack(alignment: .leading, spacing: 10){
                            Image(travel.image)
                                .resizable()
                                .frame(height: 180)
                                .cornerRadius(15)
//                            Assigning ID..
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        show.toggle()
                                        selected = travel
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            loadView.toggle()
                                        }
                                    }
                                }
                                .matchedGeometryEffect(id: travel.id, in: namespace)
                            
                            Text(travel.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            
//            Hero View...
            if show{
                VStack{
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
                        Image(selected.image)
                            .resizable()
                            .frame(height: 300)
                            .matchedGeometryEffect(id: selected.image, in: namespace)
                        if loadView{
                            HStack{
                                Button {
                                    loadView.toggle()
                                    withAnimation(.spring()){
                                        show.toggle()
                                    }
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.black.opacity(0.5))
                                        .clipShape(Circle())
                                }
                                
                                Spacer()
                                
                                Button {
                                    
                                } label: {
                                    Image(systemName: "suit.heart.fill")
                                        .foregroundColor(.red)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                            }
                            .padding(.top,35)
                            .padding(.horizontal)
                        }
                    }
                    
//                    you will get this warning because we didnt hide the old view so dont worry about that it will work fine..
                    
//                    Detail View...
                    ScrollView(.vertical, showsIndicators: false) {
//                        loading after animation completes...
                        if loadView{
                            VStack{
                                HStack {
                                    Text(selected.title)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                //                            some smale txt...
                                Text("SwiftUI uses a declarative syntax, so you can simply state what your user interface should do. For example, you can write that you want a list of items consisting of text fields, then describe alignment, font, and color for each field. Your code is simpler and easier to read than ever before, saving you time and maintenance.This declarative style even applies to complex concepts like animation. Easily add animation to almost any control and choose a collection of ready-to-use effects with only a few lines of code. At runtime, the system handles all of the steps needed to create a smooth movement, and even deals with interruption to keep your app stable. With animation this easy, you’ll be looking for new ways to make your app come alive.")
                                    .multilineTextAlignment(.leading)
                                    .padding(.top)
                                    .padding(.horizontal)
                                
                                HStack {
                                    Text("Reviews")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                HStack(spacing: 0){
                                    ForEach(1...5,id: \.self){ i in
                                        Image("g\(i)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                            .offset(x: -CGFloat(i * 20))
                                    }
                                    
                                    Spacer(minLength: 0)
                                    Button {
                                        
                                    } label: {
                                        Text("View All")
                                            .fontWeight(.bold)
                                    }
                                    

                                }
//                                since first is moved -20
                                .padding(.trailing,20)
                                .padding(.top)
                                .padding(.horizontal)
                                
//                                Carousel...
                                HStack {
                                    Text("Other Places")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                TabView{
                                    ForEach(1...6, id:\.self){ i in
//                                        ignoring the current Hero Image..
                                        if "p\(i)" != selected.image{
                                            Image("p\(i)")
                                                .resizable()
                                                .cornerRadius(15)
                                                .padding(.horizontal)
                                        }
                                    }
                                }
                                .frame(height: 250)
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                .padding(.top)
                                
//                                Button...
                                Button {
                                    
                                } label: {
                                    Text("Book Trip")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 150)
                                        .background(Color.blue)
                                        .cornerRadius(15)
                                }
                                .padding(.top,25)

                            }
                        }
                    }
                }
                .background(Color.white)
            }
            
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
//        hidding for hero View...
        .statusBar(hidden: show ? true : false)
    }
}

struct ViewHeroAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ViewHeroAnimation()
    }
}

//sample Data...

struct Travel : Identifiable {
    var id : Int
    var image : String
    var title : String
}

var dataT = [
    
    Travel(id: 0, image: "p0", title: "montanga1"),
    Travel(id: 1, image: "p1", title: "montanga2"),
    Travel(id: 2, image: "p2", title: "montanga3"),
    Travel(id: 3, image: "p3", title: "montanga4"),
    Travel(id: 4, image: "p4", title: "montanga5"),
    Travel(id: 5, image: "p5", title: "montanga6")
]
