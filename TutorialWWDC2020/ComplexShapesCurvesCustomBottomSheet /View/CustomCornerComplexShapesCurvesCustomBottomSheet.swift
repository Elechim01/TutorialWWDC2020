//
//  CustomCornerComplexShapesCurvesCustomBottomSheet.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 27/11/21.
//

import SwiftUI

struct CustomCornerComplexShapesCurvesCustomBottomSheet: Shape {
   
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}

