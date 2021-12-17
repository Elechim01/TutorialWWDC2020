//
//  AddPageViewRealmDBCRUDOperations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 13/12/21.
//

import SwiftUI

struct AddPageViewRealmDBCRUDOperations: View {
    @EnvironmentObject var modelData: DBViewModelRealmDBCRUDOperations
    @Environment(\.presentationMode) var presentation
    var body: some View {
//       To Get From Like View...
        NavigationView{
            List{
                Section {
                    TextField("",text: $modelData.title)
                } header: {
                    Text("Title")
                }

                Section {
                    TextField("",text: $modelData.detail)
                } header: {
                    Text("Detail")
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(modelData.updateObject == nil ? "Add Data" : "Update")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        modelData.addData(presentation: presentation)
                    } label: {
                        Text("Done")
                    }

                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }

                }
            }
        }
        .onAppear(perform: {
            modelData.setUpInitialData()
        })
        .onDisappear {
            modelData.deIntData()
        }
       
    }
}

struct AddPageViewRealmDBCRUDOperations_Previews: PreviewProvider {
    static var previews: some View {
        AddPageViewRealmDBCRUDOperations()
    }
}
