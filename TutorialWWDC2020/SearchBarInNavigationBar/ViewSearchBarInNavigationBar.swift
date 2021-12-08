//
//  ViewSearchBarInNavigationBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/12/21.
//

import SwiftUI

struct ViewSearchBarInNavigationBar: View {
    
    @State var filtereditems = apps
    
    var body: some View {
       
        CustomNavigationViewSearchBarInNavigationBar(view: AnyView(HomeViewSearchBarInNavigationBar(filteredItems: $filtereditems)),
                                                     placeHolder: "App,Games",
                                                     largeTitle: true,
                                                     title: "Michele",
                                                    onSearch: { txt in
                
//            filtering Data...
            if txt != ""{
                self.filtereditems = apps.filter{$0.name.lowercased().contains(txt.lowercased())}
            }else{
                self.filtereditems = apps
            }
        }, onCancel: {
//            Do Your Own Code When Search And Canceld..
            self.filtereditems = apps
        })
            .ignoresSafeArea()
    }
}

struct ViewSearchBarInNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        ViewSearchBarInNavigationBar()
    }
}

struct HomeViewSearchBarInNavigationBar:View {
    
//    for searchbar
    @Binding var filteredItems : [AppItemSearchBarInNavigationBar]
    
    var body: some View{
//        Apps List View...
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15){
                
//                Apps List...
                ForEach(filteredItems){ item in
//                    Card View...
                    CardViewSearchBarInNavigationBar(item: item)
                }
            }
            .padding()
        }
    }
}

//Custom Navigation view..
