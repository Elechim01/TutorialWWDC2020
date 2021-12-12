//
//  Layout2InstagramFeedLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 12/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Layout2InstagramFeedLayout: View {
    
    var cards :[CardInstagramFeedLayout]
    
    var body: some View {
        HStack(spacing: 4){
            AnimatedImage(url: URL(string: cards[0].download_url))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: ((width1 / 3)), height: 125)
                .cornerRadius(4)
                .modifier(ContextModifierInstagramFeedLayout(card: cards[0]))
            
//                123 + 123 +4 = 250
                AnimatedImage(url: URL(string: cards[1].download_url))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: ((width1 / 3)), height: 125)
                    .cornerRadius(4)
                
            if cards.count >= 2{
                AnimatedImage(url: URL(string: cards[2].download_url))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: ((width1 / 3)), height: 125)
                    .cornerRadius(4)
                    .modifier(ContextModifierInstagramFeedLayout(card: cards[1]))
            }
            
            if cards.count == 3{
                AnimatedImage(url: URL(string: cards[2].download_url))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: ((width1 / 3)), height: 125)
                    .cornerRadius(4)
                    .modifier(ContextModifierInstagramFeedLayout(card: cards[2]))
            }
        }
        .frame(maxWidth:.infinity,alignment: .leading)
    }
}

struct Layout2InstagramFeedLayout_Previews: PreviewProvider {
    static var previews: some View {
        ViewInstagramFeedLayout()
    }
}
