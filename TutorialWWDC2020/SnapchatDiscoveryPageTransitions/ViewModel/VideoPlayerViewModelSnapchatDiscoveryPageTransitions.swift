//
//  VideoPlayerViewModelSnapchatDiscoveryPageTransitions.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI
import AVKit

class VideoPlayerViewModelSnapchatDiscoveryPageTransitions: ObservableObject {
    
//    Hero Animation Properties...
    @Published var shoPlayer = false
    @Published var offset: CGSize = .zero
    @Published var scale: CGFloat = 1
    
    @Published var selectedVideo : VideoSnapchatDiscoveryPageTransitions = VideoSnapchatDiscoveryPageTransitions(player: AVPlayer())
}

