//
//  CardViewCustomCarouselSliderWithHeroAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 12/12/21.
//

import SwiftUI

struct CardViewCustomCarouselSliderWithHeroAnimations: View {
    @EnvironmentObject var model : CarouselViewModelCustomCarouselSliderWithHeroAnimations
    var card: CardCustomCarouselSliderWithHeroAnimations
    var animation: Namespace.ID
    var body: some View {
        VStack{
            Text("Monday 28 December")
                .font(.caption)
                .foregroundColor(Color.white.opacity(0.85))
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
                .padding(.top,10)
                .matchedGeometryEffect(id: "Date-\(card.id)", in: animation)
            
            HStack {
                Text(card.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 250, alignment: .leading)
                    .padding()
                    .matchedGeometryEffect(id: "Title-\(card.id)", in: animation)
                
                Spacer(minLength: 0)
            }
            
            Spacer(minLength: 0)
            
            HStack{
                Spacer(minLength: 0)
                
                if !model.showContent{
                    Text("Read More")
                
                     Image(systemName: "arrow.right")
                }
            }
            .foregroundColor(Color.white.opacity(0.9))
            .padding(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(card.cardColor
                        .cornerRadius(25)
                        .matchedGeometryEffect(id: "bgColor-\(card.cardColor)", in: animation)
        )
        .onTapGesture {
            withAnimation(.spring()){
                
                model.selectedCard = card
                model.showCard.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeIn){
                        model.showContent = true
                    }
                }
            }
        }
    }
}

struct CardViewCustomCarouselSliderWithHeroAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomCarouselSliderWithHeroAnimations()
    }
}
