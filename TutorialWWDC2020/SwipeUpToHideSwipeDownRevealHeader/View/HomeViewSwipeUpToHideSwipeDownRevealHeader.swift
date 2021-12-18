//
//  HomeViewSwipeUpToHideSwipeDownRevealHeader.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/12/21.
//

import SwiftUI

struct HomeViewSwipeUpToHideSwipeDownRevealHeader: View {
    
    @StateObject var headerData = HeaderViewModelSwipeUpToHideSwipeDownRevealHeader()
    
//    disabling boucung...
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack(alignment: .top) {
//            Header View...
            HeaderViewSwipeUpToHideSwipeDownRevealHeader()
                .zIndex(1)
                .offset(y: headerData.headerOffset)
            
//            video View...
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15){
                    
                    ForEach(1...5,id:\.self) { index in
                        
                        Image("p1\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rectSwipeUpToHideSwipeDownRevealHeader.width - 30, height: 250)
                            .cornerRadius(1)
                        
                        HStack(spacing: 10){
                                Image("p1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("New Sony Camera Unboxng And Review")
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                
                                Text("Michele . 4 hours ago")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom,15)
                    }
                }
                .padding(.top,75)
                .overlay(
//                    Geometry Reader For Getting Offset Values...
                    GeometryReader{ proxy -> Color in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
//                        storing intial MinY value...
                            if headerData.startMinY == 0{
                                headerData.startMinY = minY
                            }
                            
//                            getting extract offset value by subtracting current from start..
                            
                            let offset = headerData.startMinY - minY
                        
//                            getting scroll directon...
                            
                            if offset > headerData.offset{
                                
                                print("Top")
                                
//                                if top hiding HEader View...
                                
//                                same clearing bottom offset...
                                headerData.bottomScrollOffset = 0
                                
                                if headerData.topScrollOffset == 0{
                                    
//                                    Storing Intially to subtract the maxOffset...
                                    headerData.topScrollOffset = offset
                                }
                                
                                let progress = (headerData.topScrollOffset + getMaxOffset()) - offset
                                
//                                all conditions were going to use ternary opetator because if we use if else while swiping fast it ignore some conditons..
                                
                                let offsetCondition =  (headerData.topScrollOffset + getMaxOffset()) >= getMaxOffset() && getMaxOffset() - progress <= getMaxOffset()
                                
                                let headerOffset =  offsetCondition ? -(getMaxOffset() - progress) : -getMaxOffset()
                                
                                print(headerOffset)
                                headerData.headerOffset = headerOffset
                                
                                print(progress)
                                
                            }
                            
                            if offset < headerData.offset{
                                
                                print("Bottom")
                                
//                                if bottom revelaing header view..
//                                clearing topScrollvalue and setting bottom...
                                
                                headerData.topScrollOffset = 0
                                
                                if headerData.bottomScrollOffset == 0{
                                    headerData.bottomScrollOffset = offset
                                }
                                
//                                Moving if little bit of screen is swiped down...
//                                for eg 40 offset..
                                
                                withAnimation(.easeInOut(duration: 0.25)){
                                    
                                    let headerOffset = headerData.headerOffset
                                    
                                    headerData.headerOffset = headerData.bottomScrollOffset > offset + 40 ? 0 : (headerOffset != -getMaxOffset() ? 0 : headerOffset)
                                }
                                
                            }
                            
                            headerData.offset = offset
                            
                        }
                        
                        
                        return Color.clear
                    }
                    .frame(height: 0)
                    
                    ,alignment: .top
                )
            }
        }
    }
    
//    getting max Top Offset Including Top safe area...
    
    func getMaxOffset() -> CGFloat {
        return headerData.startMinY + (edgesSwipeUpToHideSwipeDownRevealHeader?.top ?? 0) + 10
    }
    
    
}

struct HomeViewSwipeUpToHideSwipeDownRevealHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSwipeUpToHideSwipeDownRevealHeader()
    }
}

//edges...

var edgesSwipeUpToHideSwipeDownRevealHeader = UIApplication.shared.windows.first?.safeAreaInsets
// Rect...
var rectSwipeUpToHideSwipeDownRevealHeader = UIScreen.main.bounds

struct HeaderViewSwipeUpToHideSwipeDownRevealHeader:View{
    
//    for dark Mode Adoption...
    @Environment(\.colorScheme) var scheme
    
    var body: some View{
        
        HStack(spacing: 20){
            Image("p1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("YouTube")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
//            Word Spacing...
                .kerning(0.5)
                .offset(x: -10)
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Image(systemName: "display")
                    .font(.title2)
                    .foregroundColor(.primary)
            }

            Button {
                
            } label: {
                Image(systemName: "bell")
                    .font(.title2)
                    .foregroundColor(.primary)
            }

            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            
            Button {
                
            } label: {
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            }


        }
        .padding(.horizontal)
        .padding(.vertical,8)
        .background((scheme == .dark ? Color.black : Color.white).ignoresSafeArea(.all, edges: .top))
//        Divider...
        .overlay(
            Divider()
            ,alignment: .bottom
        )
    }
}
