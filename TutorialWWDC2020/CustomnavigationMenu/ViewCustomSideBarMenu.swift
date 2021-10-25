//
//  ViewCustomSideBarMenu.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/10/21.
//

import SwiftUI

struct ViewCustomSideBarMenu: View {
    
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var width = UIScreen.main.bounds.width
    @State var show = false
    @State var selectedIndex = ""
    @State var min : CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack{
                ZStack {
                    HStack{
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            withAnimation(.spring()){show.toggle()}
                        } label: {
                            Image("p1")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                        }

                    }
                    
                    Text("Home")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding()
    //            since top edges are ignored...
                .padding(.top)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                
                Spacer(minLength: 0)
                
                Text(selectedIndex)
                Spacer(minLength: 0)
            }
           
//          Side Menu...
            HStack(spacing: 0){
                
                Spacer(minLength: 0)
                
                VStack{
                    HStack{
                        Spacer(minLength: 0)
                        
                        Button {
                            withAnimation(.spring()){show.toggle()}
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                        }

                    }
                    .padding()
                    .padding(.top)
                    
                    HStack(spacing: 15){
                        
                        GeometryReader{ reader in
                            Image("p1")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
//                            for getting midPoint...
                                .onAppear {
                                    self.min = reader.frame(in: .global).minY
                                }
                        }
                        .frame(width: 75, height: 75)
                    
                        VStack(alignment: .leading,spacing: 5) {
                            Text("Catherine")
                                .font(.title)
                                .fontWeight(.semibold)
                            Text("morotto91@outlook")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal )
                    
//                    Menu Buttons...
                    VStack(alignment: .leading) {
                        MenuButtonsSidebar(image: "cart", title: "My Orders",selected: $selectedIndex,show: $show)
                        MenuButtonsSidebar(image: "person", title: "My Profile",selected: $selectedIndex,show: $show)
                        MenuButtonsSidebar(image: "mappin", title: "Delivery Address",selected: $selectedIndex,show: $show)
                        MenuButtonsSidebar(image: "creditcard", title: "payment Methods",selected: $selectedIndex,show: $show)
                        MenuButtonsSidebar(image: "envelope", title: "Contact Us",selected: $selectedIndex,show: $show)
                        MenuButtonsSidebar(image: "gear", title: "Settings",selected: $selectedIndex,show: $show)
                        MenuButtonsSidebar(image: "info.circle", title: "Help & FAQs",selected: $selectedIndex,show: $show)
                    }
                    .padding(.top)
                    .padding(.leading,45)
                    Spacer(minLength: 0)
                }
                .frame(width: width - 100)
                .background(Color("bg1").clipShape(CustomShapeSideBar(min: $min)))
                .offset(x: show ? 0 : width - 100)
            }
            .background(Color.black.opacity(show ? 0.3 : 0))
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}
struct ViewCustomSideBarMenu_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomSideBarMenu()
    }
}

struct MenuButtonsSidebar: View {
    
    var image : String
    var title : String
    @Binding var selected : String
    @Binding var show : Bool
    
    var body: some View{
        Button {
            withAnimation(.spring()){
                selected = title
                show.toggle()
            }
        } label: {
            HStack(spacing: 15){
                Image(systemName: image)
                    .font(.system(size: 22))
                    .frame(width: 25, height: 25)
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding(.vertical)
            .padding(.trailing)
        }
//        For Samller Size Iphone...
        .padding(.top,UIScreen.main.bounds.width < 750 ? 0 : 5)
        .foregroundColor(.white)
    }
}

//Custom Shape
struct CustomShapeSideBar: Shape {
    
    @Binding var min : CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            path.move(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 35, y: rect.height))
            path.addLine(to: CGPoint(x: 35, y: 0))
            path.move(to: CGPoint(x: 35, y: min - 15))
//            90 - 15 = 75 Image size..
//            min + 90 => min = start => min + 90 = endpoint
//            controll or angle will be -35 to x and mid of min + 90...
//
            path.addQuadCurve(to: CGPoint(x: 35, y: min + 90), control: CGPoint(x: -35, y: min + 35))
        }
    }
}


