//
//  HomeViewRealmDBCRUDOperations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 13/12/21.
//

import SwiftUI

struct HomeViewRealmDBCRUDOperations: View {
    
    @StateObject var modelData = DBViewModelRealmDBCRUDOperations()
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack(spacing: 15){
                    ForEach(modelData.cards){card in
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(card.title)
                            Text(card.detail)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(10)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu {
                            Button {
                                modelData.deleteData(object: card)
                            } label: {
                                Text("Delete item")
                            }
                            
                            Button {
                                modelData.updateObject = card
                                modelData.openNewPage.toggle()
                            } label: {
                                Text("Update Item")
                            }


                        }
                        
                    }
                }
                .padding()
            }
            .navigationTitle("Real DB")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        modelData.openNewPage.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $modelData.openNewPage) {
                AddPageViewRealmDBCRUDOperations()
                    .environmentObject(modelData)
            }
        }
    }
}

struct HomeViewRealmDBCRUDOperations_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRealmDBCRUDOperations()
    }
}
