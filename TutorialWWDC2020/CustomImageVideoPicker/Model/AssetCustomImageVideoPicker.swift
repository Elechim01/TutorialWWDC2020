//
//  AssetCustomImageVideoPicker.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/12/21.
//

import SwiftUI
import Photos

struct AssetCustomImageVideoPicker: Identifiable {
    
    var id = UUID().uuidString
    var asset: PHAsset
    var image: UIImage
    
}

