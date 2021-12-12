//
//  CarouselViewModelCustomCarouselSliderWithHeroAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 12/12/21.
//

import SwiftUI

class CarouselViewModelCustomCarouselSliderWithHeroAnimations: ObservableObject {
   
   @Published var cards = [
        CardCustomCarouselSliderWithHeroAnimations(cardColor: Color.blue, title: "prova1"),
        CardCustomCarouselSliderWithHeroAnimations(cardColor: Color.purple, title: "prova2"),
        CardCustomCarouselSliderWithHeroAnimations(cardColor: Color.green, title: "prova3"),
        CardCustomCarouselSliderWithHeroAnimations(cardColor: Color.orange, title: "prova4"),
    ]
    
    @Published var swipeCard = 0
    
//    Detail content...
    @Published var showCard = false
    @Published var selectedCard = CardCustomCarouselSliderWithHeroAnimations(cardColor: .clear, title: "")
    
    @Published var showContent = false
    
    var content = "mjfoierfjoòewifmòneoifjweoòifjfreuhgrutyghiuejnfokelnvjehrbgulaeruinkverlughveariòonveswngvier"
}

