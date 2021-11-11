//
//  CustomCornerOnlineShopAppUIBag.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 10/11/21.
//

import SwiftUI

struct CustomCornerOnlineShopAppUIBag: Shape{
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}
