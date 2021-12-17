//
//  VideoSnapchatDiscoveryPageTransitions.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI
import AVKit

struct VideoSnapchatDiscoveryPageTransitions: Identifiable {
    
    var id = UUID().uuidString
    var player: AVPlayer
}

// getting URL From Bundle...

func getbundleURL(fileName: String) -> URL {
    let bundle = Bundle.main.path(forResource: fileName, ofType: "mp4")
    
    return URL(fileURLWithPath: bundle!)
}

var videosSnapchatDiscoveryPageTransitions = [
    VideoSnapchatDiscoveryPageTransitions(player: AVPlayer(url: getbundleURL(fileName: "video"))),
    VideoSnapchatDiscoveryPageTransitions(player: AVPlayer(url: getbundleURL(fileName: "video"))),
    VideoSnapchatDiscoveryPageTransitions(player: AVPlayer(url: getbundleURL(fileName: "video"))),
    VideoSnapchatDiscoveryPageTransitions(player: AVPlayer(url: getbundleURL(fileName: "video"))),
    
]
