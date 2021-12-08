//
//  E-CommerceAppView.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 06/12/21.
//

import SwiftUI

struct E_CommerceAppView: View {
    var body: some View {
        HomeE_CommerceAppView()
    }
}

struct E_CommerceAppView_Previews: PreviewProvider {
    static var previews: some View {
        E_CommerceAppView()
    }
}

struct HomeE_CommerceAppView: View {
    
    @State var selected = tabsecommerce[0]
    @Namespace var animation
    
    @State var show = false
    @State var selectedItem: ItemE_Commerce = itemsecommerce[0]
    
    var body: some View{
        
        ZStack{
            VStack{
                
                HStack{
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.system(size: 25, weight: .heavy))
                            .foregroundColor(.black)
                    }
                    
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image("p1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .cornerRadius(15)
                    }
                    
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                
                ScrollView{
                    VStack{
                        HStack{
                            VStack(alignment: .leading, spacing: 5) {
                                Text("let's")
                                    .font(.title)
                                    .foregroundColor(.black)
                                
                                Text("Get Started")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal)
                            
                            Spacer(minLength: 0)
                        }
                        
                        HStack(spacing:0){
                            ForEach(tabsecommerce,id:\.self){ tab in
    //                            Tab Button...
                                TabButtonE_CommerceApp(title: tab, selected: $selected, animation: animation)
                                
    //                          even spacing..
                                if tabsecommerce.last != tab{
                                    Spacer(minLength: 0)
                                }
                                
                            }
                        }
                        .padding()
                        .padding(.top,5)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 20), count: 2), spacing: 25) {
                            
                            ForEach(itemsecommerce){ item in
    //                            Card View...
                                CardViewE_CommerceApp(item: item, animation: animation)
                                    .onTapGesture {
                                        withAnimation(.spring()){
                                            selectedItem = item
                                            show.toggle()
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
                
                Spacer(minLength: 0)
            }
            .opacity(show ? 0 : 1)
            
            if show{
                DetailE_CommerceApp(selectedItem: $selectedItem, show: $show, animation: animation)
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
}

//Tabs...
var tabsecommerce = ["Glasses","Watched","Shoes","Perfume"]
