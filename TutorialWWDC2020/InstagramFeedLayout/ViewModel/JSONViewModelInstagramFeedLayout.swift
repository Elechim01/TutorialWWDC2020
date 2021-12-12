//
//  JSONViewModelInstagramFeedLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 12/12/21.
//

import SwiftUI

class JSONViewModelInstagramFeedLayout: ObservableObject {
  
    @Published var cards: [CardInstagramFeedLayout] = []
    
    @Published var search = ""
    
//    Compositional Layout Array...
    @Published var compositionalArray:[[CardInstagramFeedLayout]] = []
    
    init(){
        fetchJSON()
    }
    
    func fetchJSON() {
        let url = "https://picsum.photos/v2/list?page=2&limit=100"
        let sesion = URLSession(configuration: .default)
        sesion.dataTask(with: URL(string: url)!) { data, _, _ in
            guard let json = data else { return  }
            
            let jsonValues = try? JSONDecoder().decode([CardInstagramFeedLayout].self, from: json)
            
            guard let cards = jsonValues else { return }
            
            DispatchQueue.main.async {
                self.cards = cards
                self.setCompositionalLayout()
            }
        }
        .resume()
    }
    
    func setCompositionalLayout(){
        var currentArrayCards : [CardInstagramFeedLayout] = []
        cards.forEach { card  in
            currentArrayCards.append(card)
            
            if currentArrayCards.count == 3{
                
//                appending to Main Array...
                compositionalArray.append(currentArrayCards)
                currentArrayCards.removeAll()
            }
            
//           if not 3 or Even No of cards...
            
            if currentArrayCards.count != 3 && card.id == cards.last!.id{
                //                appending to Main Array...
                                compositionalArray.append(currentArrayCards)
                                currentArrayCards.removeAll()
            }
        }
    }
}

