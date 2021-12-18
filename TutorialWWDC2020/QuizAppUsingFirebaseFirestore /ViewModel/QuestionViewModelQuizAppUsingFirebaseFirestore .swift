//
//  QuestionViewModelQuizAppUsingFirebaseFirestore .swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/12/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class QuestionViewModelQuizAppUsingFirebaseFirestore_: ObservableObject {
    
    @Published var questions : [QuestionQuizAppUsingFirebaseFirestore_] = []
    
    func getQuestions(set: String){
//        since were having only one set in firestore so were going fetch taht one only..
        let db = Firestore.firestore()
        
//        change this to set..
        db.collection("Round1").getDocuments(){ snap, err in
            guard let data = snap else { return }
            print(data.documents)
            DispatchQueue.main.async {
                self.questions = data.documents.compactMap({ doc -> QuestionQuizAppUsingFirebaseFirestore_? in
                    return try? doc.data(as: QuestionQuizAppUsingFirebaseFirestore_.self)
                })
            }
        }
    }
}

