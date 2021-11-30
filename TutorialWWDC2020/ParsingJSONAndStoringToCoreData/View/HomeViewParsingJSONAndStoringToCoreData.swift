//
//  HomeViewParsingJSONAndStoringToCoreData.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 30/11/21.
//

import SwiftUI

struct HomeViewParsingJSONAndStoringToCoreData: View {
    @StateObject var jsonModel = JSONViewModelParsingJSONAndStoringToCoreData()
    @Environment(\.managedObjectContext) var context
    
    //    Fetching Data Fomr Core Data...
    @FetchRequest(entity: Video.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Video.titleName ,ascending : true) ]) var results : FetchedResults<Video>
    
    var body: some View {
        VStack{
            
            //            cheking if core data exists....
            if results.isEmpty{
                if jsonModel.videos.isEmpty{
                    ProgressView()
                    //                    fetching Data...
                        .onAppear {
                            jsonModel.fetchData(context: context)
                        }
                    //                    when array is clear indicator appears
                    //                    as a result data is fetched again...
                    
                }else{
                    List(jsonModel.videos,id:\.self){ video in
                        //                        display fetched JSON Data...
                        CardViewParsingJSONAndStoringToCoreData(video: video)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            else{
                List(results){ video in
                    //                        display fetched JSON Data...
                    CardViewParsingJSONAndStoringToCoreData(fetchedData: video)
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .navigationTitle(!results.isEmpty ? "Fetched Core Data" : "Fetched JSON")
        .navigationBarTitleDisplayMode(.inline)
        //            refresh button...
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
//                        by clearing array data...
//                        it will auto fetch all date again...
//                    clearing data coreData...
                    do {
                        results.forEach { video in
                            context.delete(video)
                        }
                        try context.save()
                    } catch{
                        print(error.localizedDescription)
                    }
            
                } label: {
                    Image(systemName: "arrow.clockwiste.circle")
                        .font(.title)
                }
                
            }
        }
    }
}

