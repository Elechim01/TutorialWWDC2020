//
//  ChatBubbleChatAppUsingStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

struct ChatBubbleChatAppUsingStreamSDK: Shape {
   
    var corners : UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect,byRoundingCorners: corners, cornerRadii: CGSize(width: 13, height: 13))
        
        return Path(path.cgPath)
        
    }
}

