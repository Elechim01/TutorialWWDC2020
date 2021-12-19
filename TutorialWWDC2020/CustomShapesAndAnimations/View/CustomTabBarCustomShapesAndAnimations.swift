//
//  CustomTabBarCustomShapesAndAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

struct CustomTabBarCustomShapesAndAnimations: View {
    
    @Binding var selectedTab: String
    
//    Storing Each Tab Midpoints to animated it in future..
    @State var tabPoints: [CGFloat] = []
    
    var body: some View {
        
        HStack(spacing: 0){
            
//            Tab Bar buttons...
            TabBarButtonCustomShapesAndAnimations(image: "home", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButtonCustomShapesAndAnimations(image: "bookmark", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButtonCustomShapesAndAnimations(image: "message", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButtonCustomShapesAndAnimations(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints)
        }
        .padding()
        .background(
            Color.white
                .clipShape(TabCurveCustomShapesAndAnimations(tabPoint: getCurvePoint() - 15))
        )
        .overlay(
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 20)
            ,alignment: .bottomLeading
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
//    extracting point...
    func getCurvePoint() -> CGFloat {
//        if tabpoint is empty...
        if tabPoints.isEmpty{
            return 10
        }else{
            switch selectedTab{
            case "house":
                return tabPoints[0]
            case "bookmark":
                return tabPoints[1]
            case "message":
                return tabPoints[2]
            default:
                return tabPoints[3]
                
            }
        }
    }
}

struct CustomTabBarCustomShapesAndAnimations_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewCustomShapesAndAnimations()
    }
}

struct TabBarButtonCustomShapesAndAnimations: View {
    
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    
    var body: some View{
    
//        For getting mid Point of each for curve Animation...
        GeometryReader{ reader -> AnyView in
            
//            extracting MidPoint and Storing..
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                
//                avoiding junk data...
                
                if tabPoints.count <= 4{
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
            
                Button {
    //                changing tab...
//                    spring animation...
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)){
                        selectedTab = image
                    }
                } label: {
                    
    //                filling the color if it' selected...
                    
                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color.blue)
    //                Lifting view...
    //                if its selected...
                        .offset(y: selectedTab == image ? -10 : 0)
                }
    //            Max Frame...
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
//        max Height..
        .frame(height: 50)
    }
}
