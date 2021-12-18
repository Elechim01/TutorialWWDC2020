//
//  DrawerNavigationDrawerWithSavingPageState.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct DrawerNavigationDrawerWithSavingPageState: View {
    
    @EnvironmentObject var menuData: MenuViewModelNavigationDrawerWithSavingPageState
    
//    Animation...
    var animation: Namespace.ID
    
    var body: some View {
        VStack{
            
            HStack{
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                Spacer()
                
//                Close Button...
                
                if menuData.showDrawer{
                   DrawerCloseButtonNavigationDrawerWithSavingPageState(animation: animation)
                }
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Hello")
                    .font(.title2)
                
                Text("Jenna Ezarik")
                    .font(.title)
                    .fontWeight(.heavy)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top,5)
            
//            Menu buttons....
            VStack(spacing: 22){
                MenuButtonNavigationDrawerWithSavingPageState(name: "Catalogue", image: "envelope.fill", selectedMenu: $menuData.selectedMenu,animation: animation)
                
                MenuButtonNavigationDrawerWithSavingPageState(name: "Your Cart", image: "bag.fill", selectedMenu: $menuData.selectedMenu,animation: animation)
                
                MenuButtonNavigationDrawerWithSavingPageState(name: "Favourites", image: "suit.heart.fill", selectedMenu: $menuData.selectedMenu,animation: animation)
                
                MenuButtonNavigationDrawerWithSavingPageState(name: "Your Orders", image: "list.triangle", selectedMenu: $menuData.selectedMenu,animation: animation)
                   
            }
            .padding(.leading)
            .frame(width: 250, alignment: .leading)
            .padding(.top,30)
            
            Divider()
                .background(Color.white)
                .padding(.top,30)
                .padding(.horizontal,25)
            
            Spacer()
            
            MenuButtonNavigationDrawerWithSavingPageState(name: "Sign Out", image: "rectangle.righthalf.inset.filled.arrow.right", selectedMenu: .constant(""),animation: animation)
                .padding(.bottom)
        }
//        Default Size...
        .frame(width: 250)
        .background(
            Color.black.ignoresSafeArea(.all, edges: .vertical)
        )
    }
}

struct DrawerNavigationDrawerWithSavingPageState_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewNavigationDrawerWithSavingPageState()
    }
}

// Close Button...
struct DrawerCloseButtonNavigationDrawerWithSavingPageState: View {
    
    @EnvironmentObject var menuData: MenuViewModelNavigationDrawerWithSavingPageState
    var animation: Namespace.ID
    
    var body: some View{
        Button {
            withAnimation(.easeInOut){
                menuData.showDrawer.toggle()
            }
        } label: {
            VStack(spacing: 5){
                Capsule()
                    .fill(menuData.showDrawer ? Color.white : Color.primary)
                    .frame(width: 35, height: 3)
                    .rotationEffect(.init(degrees: menuData.showDrawer ? -50 : 0))
//                Adjusting Like X....
//                Based On Traill And error...
                    .offset(x: menuData.showDrawer ? 2 : 0 , y: menuData.showDrawer ? 9 : 0)
                
                VStack(spacing: 5){
                    
                    Capsule()
                        .fill(menuData.showDrawer ? Color.white : Color.primary)
                        .frame(width: 35, height: 3)
                    
                    Capsule()
                        .fill(menuData.showDrawer ? Color.white : Color.primary)
                        .frame(width: 35, height: 3)
//                    Moving This View To Hide...
                        .offset(y: menuData.showDrawer ? -8 : 0)
                }
//                Rotating Like XMark....
                .rotationEffect(.init(degrees: menuData.showDrawer ? 50 : 0))
                
            }
        }
//        Making It Little Small..
        .scaleEffect(0.8)
        .matchedGeometryEffect(id: "MENU_BUTTON", in: animation)

    }
}
