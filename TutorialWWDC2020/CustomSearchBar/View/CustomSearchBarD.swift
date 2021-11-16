//
//  CustomSearchBarD.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/11/21.
//

import SwiftUI

struct CustomSearchBarD: View {
    
    @ObservedObject var searchData: SearchUserCustomSearchBar
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 12){
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                
                if #available(iOS 15.0, *) {
                    TextField("Search", text: $searchData.query)
                        .textInputAutocapitalization(.none)
                } else {
                    // Fallback on earlier versions
                    TextField("Search", text: $searchData.query)
                        .autocapitalization(.none)
                }
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            
            if !searchData.searchUser.isEmpty{
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(alignment: .leading, spacing: 12) {
//                        Safe Wrap...
                        ForEach(searchData.searchUser,id: \.self){ user in
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Text(user.login)
                                
                                Divider()
                            }
                            .padding(.horizontal)
                            .onAppear {
                                
//                                stopping serach untill 3rd page
//                                you can change for your own...
                                if user.node_id == searchData.searchUser.last?.node_id && searchData.page <= 3{
                                    searchData.page += 1
                                    searchData.find()
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
                .frame(height: 240)
            }
        }
        .background(Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
}

