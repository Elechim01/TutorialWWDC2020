//
//  HomeViewAnimatedStickyHeaderWithScrollableTabs.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

struct HomeViewAnimatedStickyHeaderWithScrollableTabs: View {
    @StateObject var homeData = HomeViewModelAnimatedStickyHeaderWithScrollableTabs()
//    for Dark mode Adoption..
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ScrollView{
//            Since Were Pinning Header View..
            LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders]) {
                
//                Parallax Header...
                GeometryReader{reader -> AnyView in
                    
                    let offset = reader.frame(in: .global).minY
                    
                    if -offset >= 0{
                        DispatchQueue.main.async {
                            self.homeData.offset = -offset
                        }
                    }
                    
                    return AnyView(
                        Image("g1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 250 + (offset > 0 ? offset : 0))
                            .cornerRadius(2)
                            .offset(y: (offset > 0 ? -offset : 0))
                            .overlay(
                                HStack{
                                    
                                    Button(action:{
                                        
                                    },label:{
                                        Image(systemName: "arrow.left")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    })
                                    
                                    Spacer()
                                    
                                    Button(action:{
                                        
                                    },label:{
                                        Image(systemName: "suit.heart.fill")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    })
                                }
                                    .padding(),
                                alignment: .top
                            )
                    )
                   
                }
                .frame(height: 250)
                
//                Cards...
                Section(header: HeaderViewAnimatedStickyHeaderWithScrollableTabs()) {
                    
                    ForEach(tabsItemsAnimatedStickyHeaderWithScrollableTabs){ tab in
                        VStack(alignment: .leading, spacing: 15) {
                            Text(tab.tab)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom)
                                .padding(.leading)
                            
                            ForEach(tab.foods){ food in
                                CardViewAnimatedStickyHeaderWithScrollableTabs(food: food)
                            }
                            
                            Divider()
                                .padding(.top)
                        }
                        .tag(tab.tab)
                        .overlay(
                            GeometryReader{ reader -> Text in
                                
//                                Calculating Whicj tab...
                                
                                let offset = reader.frame(in: .global).minY
                                
                                
//                                Top Area Plus Header Size 100
                                let height = UIApplication.shared.windows.first!.safeAreaInsets.top + 100
                                
                                if -offset < height && offset > 50 && homeData.selectedtab != tab.tab{
                                    DispatchQueue.main.async {
                                        self.homeData.selectedtab = tab.tab
                                    }
                                }
                                
                                return Text("")
                            }
                        )
                    }
                }
            }
        }
        .overlay(
//            Only Safe Area...
            (scheme == .dark ? Color.black : Color.white)
                .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                .ignoresSafeArea(.all,edges: .top)
                .opacity(homeData.offset > 250 ? 1 : 0)
            ,alignment: .top
        )
//        Used It Enviroment Object For Accessing All Sub Objects...
        
        .environmentObject(homeData)
    }
}

struct HomeViewAnimatedStickyHeaderWithScrollableTabs_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewAnimatedStickyHeaderWithScrollableTabs()
    }
}
