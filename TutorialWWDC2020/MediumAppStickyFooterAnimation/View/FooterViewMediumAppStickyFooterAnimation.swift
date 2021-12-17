//
//  FooterViewMediumAppStickyFooterAnimation.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct FooterViewMediumAppStickyFooterAnimation: View {
    
//    Dark Mode....
    @State var darkMode = false
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        
        HStack{
            Button {
                
            } label: {
                Image(systemName: "hads.clap.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            
            Group{
                
                Button {
                    <#code#>
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
//                Reducing distance While Scrolling...
                .offset(x: offset == 0 ? 0 : 50 * (offset / 120))

                Button {
                    <#code#>
                } label: {
                    Image(systemName: "bookmark")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
                
                Button {
                    withAnimation {
                        darkMode.toggle()
                    }
                } label: {
                    Image(systemName: darkMode ? "sun.min.fill" : "moon")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
            }
            .offset(x: offset)
        }
        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 15)
        .padding(.top)
//        MaxHeight...
        .frame(height: 80)
        .background(darkMode ? Color.black : Color.white)
        .preferredColorScheme(darkMode ? .dark : .light)
        .overlay(
//            Geometry Reader For Getting MaxY And Animations...
            
            GeometryReader{ proxy -> Color in
                
                let maxY = proxy.frame(in: .global).maxY
                
                let maxHeight = UIScreen.main.bounds.height
                
                DispatchQueue.main.async {
                    if maxY < maxHeight{
                       
                        if offset <= 120{
    //                        Smoothly Moving the Offset To 120...
                            
    //                        Upto -100 top Scroll...
    //                        its Your Wish to Animate...
                            let progress = (maxHeight - maxY) / 100
                            
                            self.offset = progress * 120 <= 120 ? progress * 120 : 120
                        }
                    }else{
                        if offset != 0{
//                            if Scrolled Too Fast...
                            self.offset = 0
                        }
                    }
                }
                
                return Color.clear
            },
            alignment: .bottom
        )
    }
}

struct FooterViewMediumAppStickyFooterAnimation_Previews: PreviewProvider {
    static var previews: some View {
       HomeViewMediumAppStickyFooterAnimation()
    }
}
