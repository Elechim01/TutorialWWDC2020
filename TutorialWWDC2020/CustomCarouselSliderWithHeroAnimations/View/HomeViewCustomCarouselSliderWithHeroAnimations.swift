//
//  HomeViewCustomCarouselSliderWithHeroAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 11/12/21.
//

import SwiftUI

//width...
var width = UIScreen.main.bounds.width
struct HomeViewCustomCarouselSliderWithHeroAnimations: View {
    
    @EnvironmentObject var model:CarouselViewModelCustomCarouselSliderWithHeroAnimations
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack{
                
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    
                    Text("Health Tips")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading)
                    
                    Spacer()

                }
                .padding()
                
    //            Carousel...
                ZStack{
                    ForEach(model.cards.indices.reversed(),id:\.self){ index in
                        HStack {
                            CardViewCustomCarouselSliderWithHeroAnimations(card: model.cards[index], animation: animation)
                                .frame(width: getCardWidth(index: index), height: getCardHeight(index: index))
                            .offset(x: getCardOffset(index: index))
                            .rotationEffect(.init(degrees: getCardRotation(index: index)))
                            
                            Spacer(minLength: 0)
                        }
                        .frame(height: 400)
                        .contentShape(Rectangle())
                        .offset(x: model.cards[index].offset)
                        .gesture(DragGesture(minimumDistance: 0)
                                    .onChanged({ value in
                            onChanged(value: value, index: index)
                        })
                                    .onEnded({ value in
                                    onEnd(value: value, index: index)
                        }))
                    }
                }
                .padding(.top,25)
                .padding(.horizontal,30)
                
                Button {
                    ResetViews()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .padding(.top,35)

                
                Spacer()
            }
            
//            Detail View...
            
            if model.showCard{
                DetailViewCustomCarouselSliderWithHeroAnimations(animation: animation)
            }
        }
    }
    
//    Resetting View...
    
    func ResetViews(){
        for index in model.cards.indices{
            withAnimation(.spring()) {
                model.cards[index].offset = 0
                model.swipeCard = 0
            }
        }
    }
    
    
    func onChanged(value: DragGesture.Value,index:Int){
        
//        Only Left Swipe...
        if value.translation.width < 0{
            model.cards[index].offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value,index:Int){
        
        withAnimation {
            
            if -value.translation.width > width / 3{
                
                model.cards[index].offset = -width
                model.swipeCard += 1
                
            }else{
                model.cards[index].offset = 0
            }
        }
        
    }
    
//    Getting Rotation when Card is being siped...
    func getCardRotation(index: Int) -> Double {
        let boxwidth = Double(width / 3)
        
        let offset = Double(model.cards[index].offset)
        
        let angle : Double = 5
        
        return (offset / boxwidth) * angle
    }
    
    
//    getting width And Heght For Card
    func getCardHeight(index:Int)->CGFloat{
        
        let height : CGFloat = 400
//        Again First Three Cards..
        let cardHeight = index - model.swipeCard <= 2 ? CGFloat(index - model.swipeCard) * 35 : 70
        
        return height - cardHeight
    }
    
    func getCardWidth(index:Int)->CGFloat{
        
        let boxwidth = UIScreen.main.bounds.width - 60 - 60
        
//        For first 3 Cards..
//        let cardWidth = index <= 2 ? CGFloat(index) * 30 : 60
        
        return boxwidth
    }
    
//    Getting Offset..
    func getCardOffset(index:Int) -> CGFloat {
        return index - model.swipeCard <= 2 ? CGFloat(index - model.swipeCard) * 30 : 60
    }
}

struct HomeViewCustomCarouselSliderWithHeroAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomCarouselSliderWithHeroAnimations()
    }
}
