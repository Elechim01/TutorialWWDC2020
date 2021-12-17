//
//  HomeViewReorderingGridViewItems.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/12/21.
//

import SwiftUI

struct HomeViewReorderingGridViewItems: View {
    
    @StateObject var pageData = PageViewModelReorderingGridViewItems()
//    Slide Animation..
    @Namespace var animation
    
//    Columns...
    let columns = Array(repeating: GridItem(.flexible(),spacing: 45), count: 2)
    
    var body: some View {
        
        VStack{
            
//            Custom Picker...
            
            HStack{
                Image(systemName: "eyeglasses")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(pageData.selectedTab == "private" ? .black : .white)
                    .frame(width: 80, height: 45)
                    .background(
                        ZStack{
                            if pageData.selectedTab != "private"{
                                Color.clear
                            }else{
                                Color.white
                                    .cornerRadius(10)
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                            }
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            pageData.selectedTab = "private"
                        }
                    }
                
                Text("1")
                    .frame(width: 35, height: 35)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(pageData.selectedTab == "tabs" ? .black : .white,lineWidth: 3))
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(pageData.selectedTab == "tabs" ? .black : .white)
                    .frame(width: 80, height: 45)
                    .background(
                        ZStack{
                            if pageData.selectedTab != "tabs"{
                                Color.clear
                            }else{
                                Color.white
                                    .cornerRadius(10)
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                            }
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            pageData.selectedTab = "tabs"
                        }
                    }
                
                Image(systemName: "laptopcomputer")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(pageData.selectedTab == "device" ? .black : .white)
                    .frame(width: 80, height: 45)
                    .background(
                        ZStack{
                            if pageData.selectedTab != "device"{
                                Color.clear
                            }else{
                                Color.white
                                    .cornerRadius(10)
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                            }
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            pageData.selectedTab = "device"
                        }
                    }
            }
            .background(Color.white.opacity(0.15))
            .cornerRadius(15)
            .padding(.top)
            
            ScrollView{
                
//                Tabs with Pages...
                LazyVGrid(columns: columns,spacing: 20) {
                    ForEach(pageData.urlsReorderingGridViewItems){ page in 
                        WebViewReorderingGridViewItems(url: page.url)
//                        Commento solo per provare...
                            .opacity(pageData.currentPage?.id == page.id ? 0.01 : 1)
                            .frame(height: 200)
                            .cornerRadius(15)
//                        Drag And Drop...
                            .onDrag {
                                
//                                setting current page...
//                                pageData.currentPage = page solo per provare
                                
//                                Sending ID For Sample...
                                return NSItemProvider(contentsOf: URL(string: "\(page.id)")!)!
                            }
                            .onDrop(of: [.url], delegate: DropViewDelegateReorderingGridViewItems(page: page,pageData:pageData))
                    }
                }
                .padding()
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea(.all, edges: .all))
    }
}

struct HomeViewReorderingGridViewItems_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewReorderingGridViewItems()
    }
}
