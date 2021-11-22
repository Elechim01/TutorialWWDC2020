//
//  ViewSideTabBarView.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/11/21.
//

import SwiftUI

struct ViewSideTabBarView: View {
    var body: some View {
        HomeViewSideTabBarView()
    }
}

struct ViewSideTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        ViewSideTabBarView()
    }
}

struct HomeViewSideTabBarView: View  {
    
    @State var midY : CGFloat = 0
    @State var selected = "Shakes"
    @State var search = ""
    
    var body: some View{
        
        HStack(spacing: 0){
            VStack{
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                }
                
                Spacer(minLength: 0)
                
                ForEach(tabs,id:\.self) { name in
                    
                    ZStack{
                        
                        Circle()
                            .fill(Color.orange.opacity(0.3))
                            .frame(width: 13, height: 13)
                            .offset(x: selected == name ? 28 : -50)
                        
                        Color.orange
                            .frame(width: 150, height: 110)
                            .rotationEffect(.init(degrees: -90))
                            .offset(x: -50)
                        
                        GeometryReader{ reader in
                            Button {
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.65, blendDuration: 0.65)){
                                    self.midY = reader.frame(in: .global).midY
                                    self.selected = name
                                }
                            } label: {
                                Text(name)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 150, height: 110)
    //                     default frame...
                            .rotationEffect(.init(degrees: -90))
                            
    //                        getting Initial first Curve Position...
                            .onAppear {
                                if name == tabs.first{
                                    self.midY = reader.frame(in: .global).midY
                                }
                            }
                            .offset(x: -8)
                        }
                        .frame(width: 150, height: 110)
                    }
                }
                
                Spacer(minLength: 0)

            }
            .frame(width: 70)
            .background(
                Color.orange
                    .clipShape(CurveViewSideTabBarView(midY: midY))
                    .ignoresSafeArea()
            )
            
            VStack{
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "cart")
                            .font(.title2)
                            .foregroundColor(.black)
                    }

                }
                .padding()
                
                HStack{
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text("Smoothie King")
                            .font(.title)
                            .fontWeight(.heavy)
                        
                        Text("Shakes")
                            .font(.title)
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(spacing: 15){
                    
                    TextField("Search", text: $search)
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.vertical,10)
                .background(Color.black.opacity(0.06))
                .clipShape(Capsule())
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 15){
//                        Items...
                        ForEach(itemsViewSideTabBarView){item in
                            ItemViewItemViewSideTabBarView(item: item)
                        }
                    }
                    .padding()
                    .padding(.top)
                }
            }
            .padding(.leading)
            
            Spacer()
        }
    }
}


//Itemview...
struct ItemViewItemViewSideTabBarView: View {
    
    var item: ItemViewSideTabBarView
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text(item.title)
                            .fontWeight(.heavy)
                        
                        Text(item.cost)
                            .fontWeight(.heavy)
                    }
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "suit.heart")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                }
                .padding([.horizontal,.top])
                .padding(.bottom,-15)
                
                Image(item.image)
                    .resizable()
                    .frame(width: 350, height: 400)
                    .offset(x: -30)
            }
            .background(
                Color(item.image)
                    .cornerRadius(35)
                    .clipShape(ItemCurveViewSideTabBarView())
                    .padding(.bottom,35)
            )
            
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color(item.image))
                    .clipShape(Circle())
            }
            .offset(y: -18)

        }
    }
}

// tabs...

var tabsViewSideTabBarView = ["Shakes","Coffe","Drink","Cocktail"]

//Custom Curve...
struct CurveViewSideTabBarView: Shape {
    
    var midY: CGFloat
    
//    animating...
    var animatableData: CGFloat{
        get{return midY}
        set{midY = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
          
           
            
//            Curve...
            
            let width = rect.width
            path.move(to: CGPoint(x: width, y: midY - 40))
            
            let to = CGPoint(x: width - 25, y: midY)
            let control1 = CGPoint(x: width, y: midY - 20)
            let control2 = CGPoint(x: width - 25, y: midY - 20)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            
            let to1 = CGPoint(x: width, y: midY + 40)
            let control3 = CGPoint(x: width - 25, y: midY + 20)
            let control4 = CGPoint(x: width, y: midY + 20)
            
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}

// Another Longer Curve For ItemView...
struct ItemCurveViewSideTabBarView: Shape {
    
  
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
          
           
            
//            Curve...
            
            let width = rect.width
            let midY = rect.height / 2
            
            path.move(to: CGPoint(x: width, y: midY - 60))
            
            let to = CGPoint(x: width - 40, y: midY)
            let control1 = CGPoint(x: width, y: midY - 30)
            let control2 = CGPoint(x: width - 40, y: midY - 30)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            
            let to1 = CGPoint(x: width, y: midY + 60)
            let control3 = CGPoint(x: width - 40, y: midY + 30)
            let control4 = CGPoint(x: width, y: midY + 30)
            
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}


// Item Model And Data...
struct ItemViewSideTabBarView: Identifiable {
    var id = UUID().uuidString
    var title: String
    var cost: String
    var image: String
}

var itemsViewSideTabBarView = [
    ItemViewSideTabBarView(title: "prova1", cost: "$4", image: "p1"),
    ItemViewSideTabBarView(title: "prova2", cost: "$4", image: "p2")
]
