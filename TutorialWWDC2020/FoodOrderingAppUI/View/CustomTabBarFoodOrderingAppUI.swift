//
//  CustomTabBarFoodOrderingAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/12/21.
//

import SwiftUI

struct CustomTabBarFoodOrderingAppUI: View {
    
    @Binding var selectedTab: String
    
//    Animation Namespace for sliding effect..
    @Namespace var animation
    var body: some View {
        HStack(spacing: 0){
            
//          Tab Bar Button...
            TabBarButtonViewFoodOrderingAppUI(animation: animation, image: "home",selecteTab: $selectedTab)
            
            TabBarButtonViewFoodOrderingAppUI(animation: animation, image: "heart",selecteTab: $selectedTab)
            
            Button {
                
            } label: {
                Image("serech")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.pink)
                    .clipShape(Circle())
//                shadows..
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)

            }
            .offset(y: -30)

            
            TabBarButtonViewFoodOrderingAppUI(animation: animation, image: "bell",selecteTab: $selectedTab)
            
            TabBarButtonViewFoodOrderingAppUI(animation: animation, image: "cart",selecteTab: $selectedTab)
        }
        .padding(.top)
//        decreasing the extra padding added...
        .padding(.vertical,-10)
        .padding(.bottom,getSafeAreaFoodOrderingAppUI().bottom == 0 ? 15 : getSafeAreaFoodOrderingAppUI().bottom)
        .background(Color.white)
    }
}

struct CustomTabBarFoodOrderingAppUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewFoodOrderingAppUI()
    }
}

// extending view to get safe area...
extension View{
    func getSafeAreaFoodOrderingAppUI()->UIEdgeInsets{
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

struct TabBarButtonViewFoodOrderingAppUI: View{
    
    var animation: Namespace.ID
    var image: String
    @Binding var selecteTab: String
    
    var body: some View{
        Button {
            withAnimation(.spring()){
                selecteTab = image
            }
        } label: {
            VStack(spacing: 8){
                Image(image)
                    .resizable()
//                Since its asset image..
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                    .foregroundColor(selecteTab == image ? Color.red : Color.gray.opacity(0.5))
                
                if selecteTab == image{
                    Circle()
                        .fill(Color.red)
//                    Sliding Effect..
                        .matchedGeometryEffect(id: "TAb", in: animation)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
        }

    }
}
