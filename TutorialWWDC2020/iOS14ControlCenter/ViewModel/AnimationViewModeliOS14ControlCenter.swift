//
//  AnimationViewModeliOS14ControlCenter.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 26/12/21.
//

import SwiftUI

class AnimationViewModeliOS14ControlCenter: ObservableObject {
   
//    Properites And Actions To be sone when is cliked...
    @Published var airplaneMode = false
    @Published var dataMode = false
    @Published var NFCMode = false
    @Published var hotspotMode = false
    @Published var airDropMode = false
    @Published var WIFIMode = false
    
    @Published var enalrgeActions = false
    @Published var showDetail = false
}

