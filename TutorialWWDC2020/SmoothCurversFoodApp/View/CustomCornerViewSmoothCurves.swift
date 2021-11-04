//
//  CustomCornerViewSmoothCurves.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 04/11/21.
//

import SwiftUI

struct CustomCornerSmoothCurves: Shape {
    
    var corner: UIRectCorner
    var size: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: size, height: size))
        return Path(path.cgPath)
    }
}
