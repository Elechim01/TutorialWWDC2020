//
//  HeaderViewModelSwipeUpToHideSwipeDownRevealHeader.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/12/21.
//

import SwiftUI

class HeaderViewModelSwipeUpToHideSwipeDownRevealHeader: ObservableObject {
   
//    To Capture Start MinY value For Calulations...
    @Published var startMinY: CGFloat = 0
    
    @Published var offset: CGFloat = 0
    
//    Header View Properties..
    @Published var headerOffset: CGFloat = 0
    
//     it will be used for getting top and bottom offsets for header view....
    @Published var topScrollOffset: CGFloat = 0
    @Published var bottomScrollOffset: CGFloat = 0
}

