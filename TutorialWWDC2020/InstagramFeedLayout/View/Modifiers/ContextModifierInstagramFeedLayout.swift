//
//  ContextModifierInstagramFeedLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 12/12/21.
//

import SwiftUI

struct ContextModifierInstagramFeedLayout: ViewModifier {
   
//    contextMenu Modifier...
    
    var card: CardInstagramFeedLayout
    
    func body(content: Content) -> some View {
        content
            .contextMenu{
                Text("By \(card.author)")
            }
            .contentShape(RoundedRectangle(cornerRadius: 5))
    }
}

