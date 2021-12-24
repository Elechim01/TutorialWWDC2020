//
//  HomeViewModelSearchBarWithCombine.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI
import Combine
import CryptoKit

class HomeViewModelSearchBarWithCombine: ObservableObject {
  
    @Published var searchQuery = ""
    
//     combine Framework Search Bar...
    
//    used to cancel the search publisher when ever we need...
    var searchCancellable: AnyCancellable? = nil
    
//    fetched Data...
    @Published var fetchedCharacters : [CharacterSearchBarWithCombine]? = nil
    
//    Comic View Data...
    @Published var fetchedComics: [ComicSearchBarWithCombine] = []
    
    @Published var offset: Int = 0
    
    
    init(){
//        since SwifUI uses @published so its a published...
//        so we dont need to explicitly define publisher...
        searchCancellable = $searchQuery
//        removing duplicate typings...
            .removeDuplicates()
//        we dont need to fetch for every typing...
//        so it will wait for 0.5 after user ends typing..
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == ""{
//                    reset Data...
                    self.fetchedCharacters = nil
                }else{
//                    search Date...
                    self.searchCharater()
                }
            })
    }
    
    
    func searchCharater(){
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privatekeyMarver)\(pubblickeyMarvel)")
        let originalQuery = searchQuery.replacingOccurrences(of: "", with: "%20")
        
        let url = "https://gateway.marvel.com:443/v1/public/characters?nameStarsWidth=\(originalQuery)&ts=\(ts)&apikey=\(pubblickeyMarvel)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { data, _, err in
            
            if let error = err{
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else {
                print("no data found")
                return
            }
            
            do {
            
//                decoding API Data..
                
                let characters = try JSONDecoder().decode(APIResultSearchBarWithCombine.self, from: APIData)
                
                DispatchQueue.main.async {
                    
                    if self.fetchedCharacters == nil{
                        self.fetchedCharacters = characters.data.results
                    }
                }
                
            } catch  {
                print(error.localizedDescription)
            }
        }
        .resume()
        
    }
    
//     to generate HSh Were going to use cryptoKit...
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    func fetchComics(){
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privatekeyMarver)\(pubblickeyMarvel)")
       
        
        let url = "https://gateway.marvel.com:443/v1/public/comics?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(pubblickeyMarvel)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { data, _, err in
            
            if let error = err{
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else {
                print("no data found")
                return
            }
            
            do {
            
//                decoding API Data..
                
                let characters = try JSONDecoder().decode(APIComicResultSearchBarWithCombine.self, from: APIData)
                
                DispatchQueue.main.async {
                    self.fetchedComics.append(contentsOf: characters.data.results)
                }
                
            } catch  {
                print(error.localizedDescription)
            }
        }
        .resume()
        
    }
    
}

