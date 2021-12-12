//
//  ViewCustomCarouselSliderWithHeroAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 11/12/21.
//

import SwiftUI

struct ViewCustomCarouselSliderWithHeroAnimations: View {
    
    @StateObject var homeModel = CarouselViewModelCustomCarouselSliderWithHeroAnimations()
    
    var body: some View {
        HomeViewCustomCarouselSliderWithHeroAnimations()
//        using it as Enviroment Object...
            .environmentObject(homeModel)
    }
}

struct ViewCustomCarouselSliderWithHeroAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomCarouselSliderWithHeroAnimations()
    }
}
