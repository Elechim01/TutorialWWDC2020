//
//  SideMenuViewCustomSlideOutMenu.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

struct SideMenuViewCustomSlideOutMenu: View {
    
    @Binding var selectedTab: String
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
        
//                Profile Pic...
            Image("p1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(10)
//                Padding top for Top Close Button..
                .padding(.top,50)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text("Jena Ezarik")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Button {
                    
                } label: {
                    Text("View Profile")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.7)
                }

            }
            
//                tab Buttons...
            VStack(alignment: .leading,spacing: 10){
                
                TabButtonViewCustomSlideOutMenu(image: "house", title: "Home", selectedTab: $selectedTab, animation: animation)
                
                TabButtonViewCustomSlideOutMenu(image: "clock.arrow.circlepath", title: "History", selectedTab: $selectedTab, animation: animation)

                TabButtonViewCustomSlideOutMenu(image: "bell.badge", title: "Notifications", selectedTab: $selectedTab, animation: animation)

                TabButtonViewCustomSlideOutMenu(image: "gearshape.fill", title: "Settings", selectedTab: $selectedTab, animation: animation)
                
                TabButtonViewCustomSlideOutMenu(image: "questionmark.circle", title: "Help", selectedTab: $selectedTab, animation: animation)

            }
            .padding(.leading,-15)
            .padding(.top,50)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 6) {
                //                Sign Out Button...
                TabButtonViewCustomSlideOutMenu(image: "rectangle.righthalf.inset.filled.arrow.right", title: "Log out", selectedTab: .constant(""), animation: animation)
                    .padding(.leading,-15)
                
                Text("App Version 1.2.34")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(0.6)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

    }
}

struct SideMenuViewCustomSlideOutMenu_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomSlideOutMenu()
    }
}
