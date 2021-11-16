//
//  ViewCustomSearchBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/11/21.
//

import SwiftUI

struct ViewCustomSearchBar: View {
    var body: some View {
        NavigationView{
            HomeViewCustomSearchBar()
                .preferredColorScheme(.dark)
                .navigationTitle("GitHub Users")
        }
    }
}

struct ViewCustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomSearchBar()
    }
}

struct HomeViewCustomSearchBar: View {
    
    @StateObject var seaachData = SearchUserCustomSearchBar()
    
    var body: some View{
        VStack{
            CustomSearchBarD(searchData:seaachData)
            
            Spacer()
        }
        .onChange(of: seaachData.query) { newValue in

//            the logic is, i attend when the user crate text or part of the text, i'dont reseach sigle caratter
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                if newValue == seaachData.query{
                    print("search \(newValue)")
                    
                    if seaachData.query != "" {
                        
//                        seraching User....
                        seaachData.page = 1
                        seaachData.find()
                        
                    }else{
//                        Removing all serchaed Data...
                        seaachData.searchUser.removeAll()
                    }
                    
                }
            }
        }
    }
}
