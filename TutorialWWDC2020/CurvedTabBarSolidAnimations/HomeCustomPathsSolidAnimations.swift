//
//  HomeCustomPathsSolidAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/09/21.
//

import SwiftUI

struct HomeCustomPathsSolidAnimations: View {
    @State var index = 0
    @State var curvePos : CGFloat = 0
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Color("Color3")
//            Tab Bar....
            HStack{
//                using it for reading curve position...
                GeometryReader{g in
                    VStack{
                        Button {
                            withAnimation(.spring()){
                                index = 0
                                self.curvePos = g.frame(in: .global).midX
                            }
                        } label: {
                            Image(systemName: "house")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(index == 0 ? .black : .gray)
                                .frame(width: 28, height: 28)
                                .padding(.all,15)
//                            animating View...
                                .background(Color.white.opacity(index == 0 ? 1 : 0).clipShape(Circle()))
                                .offset(y: index == 0 ? -35 : 0)
                        }
                    }
//                    28 + padding 15 = 43
                    .frame(width: 43, height: 43)
                    .onAppear {
//                        getting initial index position...
                        DispatchQueue.main.async {
                            self.curvePos = g.frame(in: .global).midX
                        }
                    }
                }
                .frame(width: 43, height: 43)
                Spacer(minLength: 0)
                GeometryReader{g in
                    VStack{
                        Button {
                            withAnimation(.spring()){
                                index = 1
//                                assigning it whenever its button is cliked...
                                self.curvePos = g.frame(in: .global).midX
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(index == 1 ? .black : .gray)
                                .frame(width: 28, height: 28)
                                .padding(.all,15)
                                .background(Color.white.opacity(index == 1 ? 1 : 0).clipShape(Circle()))
                                .offset(y: index == 1 ? -35 : 0)
                        }
                    }
//                    28 + padding 15 = 43
                    .frame(width: 43, height: 43)
                }
                .frame(width: 43, height: 43)
                Spacer(minLength: 0)
                GeometryReader{g in
                    VStack{
                        Button {
                            withAnimation(.spring()){
                                index = 2
                                self.curvePos = g.frame(in: .global).midX
                            }
                        } label: {
                            Image(systemName: "creditcard")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(index == 2 ? .black : .gray)
                                .frame(width: 28, height: 28)
                                .padding(.all,15)
                                .background(Color.white.opacity(index == 2 ? 1 : 0).clipShape(Circle()))
                                .offset(y: index == 2 ? -35 : 0)
                        }
                    }
//                    28 + padding 15 = 43
                    .frame(width: 43, height: 43)
                }
                .frame(width: 43, height: 43)
                Spacer(minLength: 0)
                GeometryReader{g in
                    VStack{
                        Button {
                            withAnimation(.spring()){
                                index = 3
                                self.curvePos = g.frame(in: .global).midX
                            }
                        } label: {
                            Image(systemName: "person.fill")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(index == 3 ? .black : .gray)
                                .frame(width: 28, height: 28)
                                .padding(.all,15)
                                .background(Color.white.opacity(index == 3 ? 1 : 0).clipShape(Circle()))
                                .offset(y: index == 3 ? -35 : 0)
                        }
                    }
//                    28 + padding 15 = 43
                    .frame(width: 43, height: 43)
                }
                .frame(width: 43, height: 43)
            }
            .padding(.horizontal,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ?  25 : 35)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ?  8 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding(.top,8)
            .background(Color.white.clipShape(QShape(curvePos: curvePos)))
            
//            going to add Curve...
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeCustomPathsSolidAnimations_Previews: PreviewProvider {
    static var previews: some View {
        HomeCustomPathsSolidAnimations()
    }
}

struct QShape: Shape{
    
//    You can alos use dispatchQueue in set but its simple..
     var curvePos : CGFloat
    
//    animating Path...
    var animatableData: CGFloat{
        get{return curvePos}
        set{curvePos = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
//            adding Curve...
            
            path.move(to: CGPoint(x: curvePos + 40, y: 0))
            path.addQuadCurve(to: CGPoint(x: curvePos - 40, y: 0), control: CGPoint(x: curvePos, y: 70))
//            using this we can control curve legth...
            
        }
    }
}
