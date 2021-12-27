//
//  BlurViewCustomActionSheet.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 27/12/21.
//

import SwiftUI

struct BlurViewCustomActionSheet: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
    
}

