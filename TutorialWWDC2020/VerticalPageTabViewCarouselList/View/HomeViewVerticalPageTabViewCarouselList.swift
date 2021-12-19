//
//  HomeViewVerticalPageTabViewCarouselList.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

struct HomeViewVerticalPageTabViewCarouselList: View {
    
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    @State var currentPage = 1
    
    var body: some View {
        
        
        ScrollView(.init()){
            
            TabView(){
                
                GeometryReader{ proxy in
                    
                    let screen = proxy.frame(in: .global)
                    
//                   Over Sliding Animation...
                    let offset = screen.minX
                    
                    let scale = 1 + (offset / screen.width)
                    
                    TabView(selection: $currentPage){
                        ForEach(1...5,id:\.self){ index in
                            Image("g\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRectVerticalPageTabViewCarouselList().width)
                                .cornerRadius(1)
                                .modifier(VerticalTabBarModifierViewVerticalPageTabViewCarouselList(screen: screen))
                                .tag(index)
        //                    Rotating Views to -90 so that it willact as Vetical Carusel...
        //                    Before Rotation Frame..

                        }
                    }
            //        Page Tab Bar...
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        //            Vertical Tab Bar...
                    .rotationEffect(.init(degrees: 90))
    //                adjusting width...
                    .frame(width: screen.width)
                    
//                    OverSliding Effect...
//                    Liting Scale...
                    .scaleEffect(scale >= 0.88 ? scale : 0.88,anchor: .center)
                    .offset(x: -offset)
                    .blur(radius: (1 - scale) * 20)
                    
                }
                
                DetailViewVerticalPageTabViewCarouselList(currentPage: $currentPage)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .background(Color.black.ignoresSafeArea())
        .ignoresSafeArea()
    }
}

struct HomeViewVerticalPageTabViewCarouselList_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewVerticalPageTabViewCarouselList()
    }
}

// Extending View to get rect...
extension View{
    func getRectVerticalPageTabViewCarouselList() -> CGRect {
        return UIScreen.main.bounds
    }
}
//                        Just Checking...
//                            .overlay(
//                                VStack{
//
//                                    Text("Hello")
//
//                                    Spacer()
//
//                                    HStack{
//
//                                        Text("Hello")
//
//                                        Spacer()
//
//                                        Text("Hello")
//                                    }
//                                    Spacer()
//
//                                    Text("Hello")
//                                }
//                                .foregroundColor(.white)
//                            )

//Detail View...
struct DetailViewVerticalPageTabViewCarouselList: View {
    
    @Binding var currentPage: Int
    
    var body: some View{
        
        VStack(spacing: 20){
            
            Text("Details")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,edgesVerticalPageTabViewCarouselList?.top ?? 15)
            
            Image("g\(currentPage)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 250)
                .cornerRadius(20)
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Dark Soul")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("By Michele")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal,30)
            
//            Buttons...
            Button {
                
            } label: {
                Text("Download Image")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white,lineWidth: 1.5)
                    )
            }
            .padding(.vertical)

            Button {
                
            } label: {
                Text("Report Image")
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.red,lineWidth: 1.5)
                    )
            }
            
            Spacer()
        }
        .padding()
        .background(Color.blue.ignoresSafeArea())
    }
}


struct VerticalTabBarModifierViewVerticalPageTabViewCarouselList: ViewModifier {
    
    var screen: CGRect
    
    func body(content: Content) -> some View {
        return content
        
            .frame(width: screen.width, height: screen.height)
            .rotationEffect(.init(degrees: -90))
//                    After Rotation Frame..
            .frame(width: screen.height, height: screen.width)
    }
}

// Edges...

var edgesVerticalPageTabViewCarouselList = UIApplication.shared.windows.first?.safeAreaInsets
