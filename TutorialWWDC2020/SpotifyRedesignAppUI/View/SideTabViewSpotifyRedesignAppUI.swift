//
//  SideTabView.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 25/12/21.
//

import SwiftUI

struct SideTabViewSpotifyRedesignAppUI: View {
   
    //    Storing Current Tab...
       @State var selectedTab = "house.fill"
        
    //    Volume...
        @State var volume: CGFloat = 0.4
        
    //    Hide Side Tab Bar...
        @State var showSideBar = false
    var body: some View {
        
//            Side Tab Bar...
        VStack{
            
            Image("p1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .padding(.top)
            
            VStack{
                
                TabButtonSpotifyRedesignAppUI(image: "house.fill", selectedTab: $selectedTab)
                
                TabButtonSpotifyRedesignAppUI(image: "safari.fill", selectedTab: $selectedTab)
                
                TabButtonSpotifyRedesignAppUI(image: "mic.fill", selectedTab: $selectedTab)
                
                TabButtonSpotifyRedesignAppUI(image: "clock.fill", selectedTab: $selectedTab)
            }
//                setting the tabs for half of the height so that remaining elements will get space...
            .frame(height: getRectSpotifyRedesignAppUI().height / 2.3)
            .padding(.top)
            
            Spacer(minLength: getRectSpotifyRedesignAppUI().height < 750 ? 30 : 50)
            
            Button {
//                    cheking and increasing volume...
                volume = volume + 0.1 < 1.0 ? volume + 0.1 : 1
            } label: {
                
                Image(systemName: "speaker.wave.2.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
//                Custom Volume Progress View...
            GeometryReader{ proxy in
                
//                    extracting progress bar height and based on that getting progress value..
                let height = proxy.frame(in: .global).height
                let progres = height * volume
                
                ZStack(alignment: .bottom){
                    
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 4)
                    
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 4,height: progres)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .padding(.vertical, getRectSpotifyRedesignAppUI().height < 750 ? 10 : 20)
            
            Button {
//                    cheking and decreasing volume...
                volume = volume - 0.1 > 0 ? volume - 0.1 : 0
            } label: {
                
                Image(systemName: "speaker.wave.1.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            Button {
                withAnimation(.easeIn){
                    showSideBar.toggle()
                }
            } label: {
                
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(.white)
//                    rotating..
                    .rotationEffect(.init(degrees: showSideBar ? -180 : 0))
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.top,getRectSpotifyRedesignAppUI().height < 750 ? 15 : 30)
            .padding(.bottom,getSafeAreaSpotifyRedesignAppUI().bottom == 0 ? 15 : 0)
            .offset(x: showSideBar ? 0 : 100)
            
        }
//            Max Side tab Bar Width..
        .frame(width: 80)
        .background(Color.black.ignoresSafeArea())
        .offset(x: showSideBar ? 0 : -100)
//            reclaming the spacing by using negative spacing....
//            if you want to move the view along with tab bar...
        .padding(.trailing,showSideBar ? 0 : -100)
//            changing the stack position
//            so that side tab bar will be on top..
        .zIndex(1)
    }
}

struct SideTabViewSpotifyRedesignAppUI_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSpotifyRedesignAppUI()
    }
}

// Tab Button...
struct TabButtonSpotifyRedesignAppUI:View {
    
    var image: String
    @Binding var selectedTab: String
    
    var body: some View{
        
        Button {
            withAnimation {
                selectedTab = image
            }
        } label: {
            
            Image(systemName: image)
                .font(.title)
                .foregroundColor(selectedTab == image ? .white : Color.gray.opacity(0.6))
                .frame(maxHeight: .infinity)
        }
    }
}

//Extending View to get Screen Size..
extension View{
    func getRectSpotifyRedesignAppUI() -> CGRect {
        return UIScreen.main.bounds
    }
//    getting safe area..
    func getSafeAreaSpotifyRedesignAppUI() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
