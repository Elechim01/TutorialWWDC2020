//
//  ViewCustomTabBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 25/10/21.
//

import SwiftUI

struct ViewCustomTabBar: View {
    
    @State var selectedTab = "house"
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @Namespace var  animation
    @StateObject var modelData = ModelViewCustom()
    
    var body: some View {
//        NavigationView{
        VStack(spacing: 0){
            GeometryReader{_ in
                ZStack{
//                    Tabs...
//                    Type 2
                    NavigationView{
                        ScrollView{
                            ForEach(1...25,id: \.self){ i in
                                
                                NavigationLink {
                                    Text("Home Data \(i)")
                                } label: {
                                    VStack(alignment: .leading){
                                        Text("Home Data \(i)")
                                            .padding()
                                            .foregroundColor(.black)
                                        
                                        Divider()
                                    }

                                }
                            }
                            .padding(.bottom)
                        }
                        .navigationBarHidden(true)
                    }
                    .opacity(selectedTab == "house" ? 1 : 0)
                    
                    Text("Restaurants")
                        .opacity(selectedTab == "menush" ? 1 : 0)
                    
                    Text("Walk")
                        .opacity(selectedTab == "steps" ? 1 : 0)
                    
                    Text("Bycle Run")
                        .opacity(selectedTab == "cycle" ? 1 : 0)
                    
                }
            }
            .onChange(of: selectedTab) { _ in
                switch(selectedTab){
                case "Restaurant": if !modelData.isRestaruantLoad{modelData.loadRestaruant()}
                case "Orders": if !modelData.isOrderLoad{modelData.loadOrers()}
                case "Rewards": if !modelData.isRewardLoad{modelData.loadReward()}
                default: ()
                }
            }
//            TabView...
            HStack(spacing: 0){
                ForEach(tabs, id: \.self){ tab in
                    TabButtonCustom(title: tab, selectedTab: $selectedTab, animation: animation )
                    if tab != tabs.last{
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal,30)
//            for iphone like 8 and SE
//            .padding(.bottom,edges!.bottom == 0 ? 15 : edges!.bottom)
            .background(Color.white)
        }
//        }
        .ignoresSafeArea(.all,edges: .bottom)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all,edges: .all))
    }
}

struct ViewCustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomTabBar()
    }
}

struct TabButtonCustom : View {
    
    var title : String
    @Binding var selectedTab : String
    var animation : Namespace.ID
    
    var body: some View{
        Button {
            withAnimation {
                selectedTab = title
            }
        } label: {
            VStack(spacing: 6){
//                Top Indicator....
                
//                Custom Shape....
                
//                Slide in and out anmation..
                ZStack{
                    CustomShapeListView()
                        .fill(Color.clear)
                        .frame(width: 45, height: 6)
                    if selectedTab == title{
                        CustomShapeListView()
                            .fill(Color("running"))
                            .frame(width: 45, height: 6)
                            .matchedGeometryEffect(id: "Tab_Change", in: animation)
                    }
                }
                .padding(.bottom,10)
                
                Image(title)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(selectedTab == title ? Color("running") : Color.black.opacity(0.2))
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(selectedTab == title ? 0.6 : 0.2))
            }
        }

    }
}
struct CustomShapeListView: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        return Path(path.cgPath)
    }
}
var tabs = ["house","menush","steps","cycle"]

// if You Having simply views and not that much network task means its fine
// else use this method to load data when the tab opens...
class ModelViewCustom: ObservableObject {
    
    @Published var isOrderLoad = false
    @Published var isRestaruantLoad = false
    @Published var isRewardLoad = false
    
    init(){
//        Load initial data..
        print("Home Data Loaded")
    }
    func loadOrers(){
        print("order Loaded")
        isOrderLoad = true
    }
    
    func loadRestaruant(){
        print("Restaruant Loaded")
        isRewardLoad = true
    }
    
    func loadReward(){
        print("Reward Loaded")
        isRewardLoad = true
    }
}
