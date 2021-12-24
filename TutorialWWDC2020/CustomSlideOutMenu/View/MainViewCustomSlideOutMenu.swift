//
//  MainViewCustomSlideOutMenu.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

struct MainViewCustomSlideOutMenu: View {
//   selected Tab....
    @State var selectedTab = "Home"
    @State var showMenu = false
    
    var body: some View {
        
        ZStack{
            
            Color.blue
                .ignoresSafeArea()
            
//            side Menu...
            
            ScrollView(getRectCustomSlideOutMenu().height < 750 ? .vertical : .init(), showsIndicators: false) {
                SideMenuViewCustomSlideOutMenu(selectedTab: $selectedTab)
            }
            
            ZStack{
//                Two background Cards...
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
//                Shadow...
                    .shadow(color: Color.black.opacity(0.7), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -25 : 0)
                    .padding(.vertical,30)
                
                Color.white
                    .opacity(0.4)
                    .cornerRadius(showMenu ? 15 : 0)
//                Shadow...
                    .shadow(color: Color.black.opacity(0.7), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -50 : 0)
                    .padding(.vertical,60)
                
                HomeViewCustomSlideOutMenu(selectedTab: $selectedTab)
                    .cornerRadius(showMenu ? 15 : 0)
           
            }
            //            Scaling and Moving The View...
                .scaleEffect(showMenu ? 0.84 : 1)
                .offset(x: showMenu ? getRectCustomSlideOutMenu().width - 120 : 0)
                .ignoresSafeArea()
                .overlay(
                    //                    Menu Button...
                    Button(action: {
                        withAnimation(.spring()){
                            showMenu.toggle()
                        }
                    }, label: {
                        
//                        Animated Draer Button...
                        VStack(spacing: 5){
                            Capsule()
                                .fill(showMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
//                            Rotating..
                                .rotationEffect(.init(degrees: showMenu ? -50 : 0))
                                .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)
                            
                            VStack(spacing: 5){
                                Capsule()
                                    .fill(showMenu ? Color.white : Color.primary)
                                    .frame(width: 30, height: 3)
//                                Moving Uo when clicked...
                                Capsule()
                                    .fill(showMenu ? Color.white : Color.primary)
                                    .frame(width: 30, height: 3)
                                    .offset(y:showMenu ? -8 : 0)
                            }
                            .rotationEffect(.init(degrees: showMenu ? 50 : 0))
                        }
                        
                    })
                        .padding()
                    ,alignment: .topLeading
                )
        }
    }
}

struct MainViewCustomSlideOutMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainViewCustomSlideOutMenu()
    }
}

//Extending View To get Screen Size...
extension View{
    
    func getRectCustomSlideOutMenu() -> CGRect {
        return UIScreen.main.bounds
    }
}
