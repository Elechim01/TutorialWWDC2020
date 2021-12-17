//
//  DBViewModelRealmDBCRUDOperations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 13/12/21.
//

import SwiftUI
import RealmSwift

class DBViewModelRealmDBCRUDOperations: ObservableObject {
    
//    Data....
    @Published var title = ""
    @Published var detail = ""
    
    @Published var openNewPage = false
    
//    Fetched Data...
    @Published var cards : [CardRealmDBCRUDOperations] = []
    
//    Data Updation....
    @Published var updateObject : CardRealmDBCRUDOperations?
    
    
    init(){
        fetchData()
    }
    
//    Fetching Data...
    func fetchData(){
        guard let dbRef = try? Realm() else { return }
        
        let results = dbRef.objects(CardRealmDBCRUDOperations.self)
        
//        Displaying results...
        self.cards = results.compactMap({ card in
            return card
        })
        
    }
    
//   Adding New Data...
    
    func addData(presentation : Binding<PresentationMode>) {
        let card = CardRealmDBCRUDOperations()
        card.title = title
        card.detail = detail
        
//        Getting Reference...
        
        guard let dbRef = try? Realm() else { return }
        
//        Writing Data....
        
        try? dbRef.write({
            
//            checking and Writing Data...
            
            guard let availableObjecr = updateObject else {
                
                dbRef.add(card)
  
                return
            }
            
            availableObjecr.title = title
            availableObjecr.detail = detail
            
        })
        
    //            Updating UI..
                fetchData()
//        closing View..
        presentation.wrappedValue.dismiss()
    }
    
//    Deleting Data...
    func deleteData(object: CardRealmDBCRUDOperations){
        guard let dbRef = try? Realm() else { return }
        
        try? dbRef.write({
            dbRef.delete(object)
            fetchData()
        })
    }
    
    
//    Setting And Clearing Data...
    func setUpInitialData(){
//        Updation...
        
        guard let updateData = updateObject else { return }
        
//        Cheking if it's update object and assigning values...
        
        title = updateData.title
        detail = updateData.detail
    }
    
    func deIntData(){
        title = ""
        detail = ""
    }
    
}
