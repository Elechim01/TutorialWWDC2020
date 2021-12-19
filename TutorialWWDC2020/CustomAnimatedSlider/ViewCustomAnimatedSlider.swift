//
//  ViewCustomAnimatedSlider.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

struct ViewCustomAnimatedSlider: View {
    var body: some View {
        HomeViewCustomAnimatedSlider()
    }
}

struct ViewCustomAnimatedSlider_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomAnimatedSlider()
    }
}

struct HomeViewCustomAnimatedSlider:View {
    
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    
//    Slider Properties...
    @State var sliderProgress: CGFloat = 0
    @State var sliderHeight: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    
    var body: some View{
        
        NavigationView{
            
            VStack{
                
//              Slider....
                
                ZStack(alignment: .bottom) {

                    Rectangle()
                        .fill(Color.blue.opacity(0.15))
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: sliderHeight)
                }
                .frame(width: 100,height: maxHeight)
                .cornerRadius(35)
//                Container...f
                .overlay(
                    Text("\(Int(sliderProgress * 100))%")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical,10)
                        .padding(.horizontal,18)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.vertical,30)
                        .offset(y: -sliderHeight < maxHeight - 105 ? -sliderHeight : -maxHeight + 105)
                    
                    ,alignment: .bottom
                )
                .gesture(DragGesture(minimumDistance: 0).onChanged({ value  in
                    
//                    getting drag value....
                    let translation = value.translation
                    
                    sliderHeight = -translation.height + lastDragValue
                    
//                    Limiting slider height value...
                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                    
//                    Negative Height...
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                    
//                    updating Progess..
                    let progress = sliderHeight / maxHeight
                                        
                    sliderProgress = progress <= 1.0 ? progress : 1
                    
                }).onEnded({ value in
                    
//                    Limiting slider height value...
                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                    
//                    Negative Height...
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                    
//                    storing last drag value for restoration....
                    lastDragValue = sliderHeight
                                        
                }))
               
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.purple.ignoresSafeArea())
            .preferredColorScheme(.dark)
            .navigationTitle("Dashboard")
        }
    }
}
