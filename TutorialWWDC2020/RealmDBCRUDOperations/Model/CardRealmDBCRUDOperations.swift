//
//  CardRealmDBCRUDOperations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 13/12/21.
//

import SwiftUI
import RealmSwift

class CardRealmDBCRUDOperations: Object,Identifiable {
   
    @objc dynamic var id : Date = Date()
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
}

