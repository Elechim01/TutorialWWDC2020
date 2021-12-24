//
//  CustomCornersViewAddtoBagAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 20/12/21.
//

import SwiftUI

struct CustomCornersViewAddtoBagAnimations: Shape {
        
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
    
}

