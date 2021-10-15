//
//  ViewCustomTabPageIcons.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 05/10/21.
//

import SwiftUI

struct ViewCustomTabPageIcons: View {
    @State var index = 0
    var body: some View {
        NavigationView{
            VStack{
            TabView(selection: $index){
                Color.red
                    .tag(0)
//                custom page icon...
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                 
                
                Color.blue
                    .tag(1)
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                    }
                
                Color.black
                    .tag(2)
                    .tabItem {
                        Image(systemName: "gear")
                    }
                
                Color.yellow
                    .tag(3)
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
                
//                to identify current index...
                
            }
            .edgesIgnoringSafeArea(.all)
//                menu....
            .toolbar(content: {
                Menu {
//                   Menu Buttons...
                    Button {
                        withAnimation {
//                            changing index...
                            index = 0
                        }
                    } label: {
                        HStack{
                            Text("Home")
                            
                            Image(systemName: "house.fill")
                        }
                    }
                    Button {
                        withAnimation {
//                            changing index...
                            index = 1
                        }
                    } label: {
                        HStack{
                            Text("Loved")
                            
                            Image(systemName: "suit.heart.fill")
                        }
                    }
                    Button {
                        withAnimation {
//                            changing index...
                            index = 2
                        }
                    } label: {
                        HStack{
                            Text("Settings")
                            
                            Image(systemName: "gear")
                        }
                    }
                    Button {
                        withAnimation {
//                            changing index...
                            index = 3
                        }
                    } label: {
                        HStack{
                            Text("Account")
                            
                            Image(systemName: "person.fill")
                        }
                    }
                    
                } label: {
                    Image(systemName: "line.horizontal.3")
                }

            })
           
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
//            backgound color...
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ViewCustomTabPageIcons_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomTabPageIcons()
    }
}
