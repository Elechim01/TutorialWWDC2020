//
//  SearchUserCustomSearchBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/11/21.
//

import SwiftUI

class SearchUserCustomSearchBar: ObservableObject {
    
    @Published var searchUser : [UserCustomSearchBar] = []
    
//    User query...
    @Published var query = ""
    
//    Current Result Page...
    @Published var page = 1
    
    func find(){
//        removing splaces...
        let searchQuery = query.replacingOccurrences(of: " ", with: "%20")
        
//        you can give your own length....
        let url = "https://api.github.com/search/users?q=\(searchQuery)&page=\(page)&per_page=10"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { data, _, err in
            
            guard let jsonData = data else {return}
            
            do {
                let users = try JSONDecoder().decode(Results.self, from: jsonData)
                
//                appending to serach Users...
                DispatchQueue.main.async {
                    
//                    removing data if its new request...
                    if self.page == 1{
                        self.searchUser.removeAll()
                    }
//                    checking if any already loaded is again loded...
                    
//                  ignores already loded...
                    
                    self.searchUser = Array(Set(self.searchUser).union(Set(users.items)))
                }
                
            } catch  {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
}
