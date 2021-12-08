//
//  QuestionQuizAppUsingFirebaseFirestore .swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/12/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

//Codable Model..
struct QuestionQuizAppUsingFirebaseFirestore_: Identifiable,Codable {
    
//    it willc fetch doc ID...
    @DocumentID var id: String?
    var question: String?
    var optionA: String?
    var optionB: String?
    var optionC: String?
    var answer: String?
//    for checking...
    var isSubmitted = false
    var completed = false
    
//    decalre the coding keys with respect to firebase firestore Key...
    
    enum CodingKeys: String,CodingKey {
        case optionA = "a"
        case answer
        case optionB = "b"
        case optionC = "c"
        case question
    }
    
}

