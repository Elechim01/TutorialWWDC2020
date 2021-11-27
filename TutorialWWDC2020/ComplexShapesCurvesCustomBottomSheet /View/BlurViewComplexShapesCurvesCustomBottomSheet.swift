//
//  BlurViewComplexShapesCurvesCustomBottomSheet.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 25/11/21.
//

import SwiftUI

struct BlurViewComplexShapesCurvesCustomBottomSheet: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

