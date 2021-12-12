//
//  HomeViewInstagramFeedLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 12/12/21.
//

import SwiftUI

struct HomeViewInstagramFeedLayout: View {
    
    @StateObject var jsonModel = JSONViewModelInstagramFeedLayout()
    
    var body: some View {
        VStack{
            
            HStack {
                HStack{
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Search",text: $jsonModel.search)
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.06))
                .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 30))
                        .foregroundColor(.primary)
                }

            }
            .padding()
            
            if jsonModel.cards.isEmpty{
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }else{
                ScrollView{
//                    Compositional Layout...
                    VStack(spacing: 4){
                        ForEach(jsonModel.compositionalArray.indices,id:\.self){ index in
                           
//                            Basic Logic For Mixing layouts..
                            
                            if index == 0 || index % 6 == 0{
                                
                                Layout1InstagramFeedLayout(cards: jsonModel.compositionalArray[index])
                                
                            }else if index % 3 == 0{
                                Layout3InstagramFeedLayout(cards: jsonModel.compositionalArray[index])

                            }
                            else{
                                Layout2InstagramFeedLayout(cards: jsonModel.compositionalArray[index])
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct HomeViewInstagramFeedLayout_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewInstagramFeedLayout()
    }
}
