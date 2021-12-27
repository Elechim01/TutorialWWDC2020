//
//  BlurViewiOS14ControlCenter.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 26/12/21.
//

import SwiftUI

struct BlurViewiOS14ControlCenter: UIViewRepresentable {
    
    var effect: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

