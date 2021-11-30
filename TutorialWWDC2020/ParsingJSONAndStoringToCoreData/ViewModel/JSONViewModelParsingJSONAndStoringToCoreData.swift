//
//  JSONViewModelParsingJSONAndStoringToCoreData.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 30/11/21.
//

import SwiftUI
import CoreData

class JSONViewModelParsingJSONAndStoringToCoreData: ObservableObject {
    
    @Published var videos: [VideoModelParsingJSONAndStoringToCoreData] = []
    
//    saving JSON To core data...
    func saveData(context: NSManagedObjectContext){
        videos.forEach { data in
            let entity = Video(context: context)
            entity.titleName = data.titleName
            entity.detail = data.detail
            entity.link = data.link
            entity.imageLink = data.imageLink
        }
        
//        saving all pending data once...
        do {
            try context.save()
            print("success")
            
        } catch{
            print(error.localizedDescription)
        }
    }
    
    func fetchData(context: NSManagedObjectContext){
        let url = "https://kavasoft.dev/api/v1/videos"
        
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("swiftui2.0", forHTTPHeaderField: "field")
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, res, _ in
            guard let jsonData = data else { return  }
            
//            cheking for any internal api error...
            
            let response = res as! HTTPURLResponse
//            cheking by status code...
            if response.statusCode == 404{
                print("error API Error")
                return
            }
            
//          fetching JSON Data...
            do {
                let videos =  try JSONDecoder().decode([VideoModelParsingJSONAndStoringToCoreData].self, from: jsonData)
                
                DispatchQueue.main.async {
                    self.videos = videos
                    self.saveData(context: context)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
}

