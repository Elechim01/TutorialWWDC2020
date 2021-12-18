//
//  HeaderViewAnimatedStickyHeaderWithScrollableTabs.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/12/21.
//

import SwiftUI

struct HeaderViewAnimatedStickyHeaderWithScrollableTabs: View {
    
    @EnvironmentObject var homeData: HomeViewModelAnimatedStickyHeaderWithScrollableTabs
    
    //    for Dark mode Adoption..
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            
            HStack(spacing: 0){
//                Back Button...
                Button {
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20,weight: .bold))
                        .frame(width: getSize(), height: getSize())
                        .foregroundColor(.primary)
                    
                }

                Text("Michele")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            ZStack{
                VStack(alignment: .leading, spacing: 10) {
                    Text("Asiatisch. Koreanish. Japnisch")
                        .font(.caption)
                    
                    HStack(spacing: 8){
                        Image(systemName: "clock")
                            .font(.caption)
                        
                        Text("30-40 Min")
                            .font(.caption)
                        
                        Text("4.3")
                            .font(.caption)
                        
                        Image(systemName: "star.fil")
                            .font(.caption)
                        
                        Text("$6.4 Fee")
                            .font(.caption)
                            .padding(.leading,10)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                }
                .opacity(homeData.offset > 200 ? 1 - Double((homeData.offset - 200) / 50) : 1)
                
//                Custom Scrollview...
                
//                for Automatic Scrolling...
                HeaderViewAnimatedStickyHeaderWithScrollableTabs1()
                    .environmentObject(homeData)
            }
//            Default frame.. = 60
//            Top Farm = 40
//            So total = 100
            .frame(height: 60)
            
            if homeData.offset > 250{
                Divider()
            }
            
            Spacer(minLength: 0)
       
        }
        .padding(.horizontal)
        .frame(height: 100)
        .background(scheme == .dark ? Color.black : Color.white)
    }
    
//    Getting Size Of button And doing Animation...
    func getSize() -> CGFloat {
        if homeData.offset > 200{
            
            let progress = (homeData.offset - 200) / 50
            
            if progress <= 1.0{
                return progress * 40
            }else{
                return 40
            }
            
            
            
        }else{
            return 0
        }
    }
    
}

struct HeaderViewAnimatedStickyHeaderWithScrollableTabs_Previews: PreviewProvider {
    static var previews: some View {
       HomeViewAnimatedStickyHeaderWithScrollableTabs()
    }
}

struct HeaderViewAnimatedStickyHeaderWithScrollableTabs1: View {
    @EnvironmentObject var homeData: HomeViewModelAnimatedStickyHeaderWithScrollableTabs
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0){
                    ForEach(tabsItemsAnimatedStickyHeaderWithScrollableTabs){ tab in
                        Text(tab.tab)
                            .font(.caption)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.primary.opacity(homeData.selectedtab == tab.tab ? 1 : 0))
                            .clipShape(Capsule())
                            .foregroundColor(homeData.selectedtab == tab.tab ? scheme == .dark ? .black : .white : .primary)
                            .id(tab.tab)
                    }
                    .onChange(of: homeData.selectedtab) { value in
                        withAnimation {
                            reader.scrollTo(homeData.selectedTab, anchor: .leading)
                        }
                    }
                }
            }
            //                Visible Only When Scrolls Up...
            .opacity(homeData.offset > 200 ? Double((homeData.offset - 200) / 50) : 0)
        }
    }
}
