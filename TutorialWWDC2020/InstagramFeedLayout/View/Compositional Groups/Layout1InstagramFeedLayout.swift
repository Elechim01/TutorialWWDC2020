//
//  Layout1InstagramFeedLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 12/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

//Width...
//padding = 30
var width1 = UIScreen.main.bounds.width - 30
struct Layout1InstagramFeedLayout: View {
    
    var cards: [CardInstagramFeedLayout]
    
    var body: some View {
        
        HStack(spacing: 4){
            AnimatedImage(url: URL(string: cards[0].download_url))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (width1 - (width1 / 3) + 4), height: 250)
                .cornerRadius(4)
                .modifier(ContextModifierInstagramFeedLayout(card: cards[0]))
            
            VStack(spacing: 4){
//                123 + 123 +4 = 250
              
                if cards.count >= 2{
                    AnimatedImage(url: URL(string: cards[1].download_url))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ((width1 / 3)), height: 123)
                        .cornerRadius(4)
                        .modifier(ContextModifierInstagramFeedLayout(card: cards[1]))
                }
                
                if cards.count == 3{
                
                AnimatedImage(url: URL(string: cards[2].download_url))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: ((width1 / 3)), height: 123)
                    .cornerRadius(4)
                    .modifier(ContextModifierInstagramFeedLayout(card: cards[2]))
                }
            }
            .frame(maxHeight:.infinity,alignment: .top)
        }
        .frame(maxWidth:.infinity,alignment: .leading)
    }
}

struct Layout1InstagramFeedLayout_Previews: PreviewProvider {
    static var previews: some View {
        ViewInstagramFeedLayout()
    }
}
