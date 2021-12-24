//
//  LandingPageFoodOrderingAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/12/21.
//

import SwiftUI

struct LandingPageFoodOrderingAppUI: View {
    
    @Binding var selectedCategory: CategoryFoodOrderingAppUI
    
    var body: some View {
        
        VStack{
            
            HStack{
                Button {
                    
                } label: {
                    Image(systemName: "circle.grid.2x2")
                        .font(.title2)
                        .padding(10)
                        .background(Color.pink.opacity(0.12))
                        .foregroundColor(Color.pink)
                        .cornerRadius(8)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .font(.title2)
                        .padding(10)
                        .background(Color.black.opacity(0.08))
                        .foregroundColor(Color.pink)
                        .cornerRadius(8)
                }
            }
            .overlay(
                HStack(spacing: 4){
                    Image(systemName: "mappin")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color.pink)
                    
                    Text("California, US")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            )
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading,spacing: 15){
                    
//                    Top view...
                    HStack(spacing: 20){
                        
                        VStack(alignment: .leading, spacing: 12) {
                            (
                                Text("The Fastest in Delivery  ")
                                +
                                Text("Food")
                                    .foregroundColor(.pink)
                            )
                            .font(.title2)
                            .fontWeight(.bold)
                            
//                            Button...
                            Button {
                                
                            } label: {
                                Text("Order Now")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .padding(.horizontal)
                                    .background(Color.pink)
                                    .clipShape(Capsule())
                            }

                        }
                        .padding(.leading)
                        
                        Spacer(minLength: 0)
                        
                        Image("g1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: getRectFoodOrderingAppUI().width / 3)
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.4))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
//                    Categories View...
                    Text("Categories")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 15){
                            
                            ForEach(categoriesFoodOrderingAppUI){ category in
                                
                                HStack(spacing: 12){
                                    Image(category.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 18, height: 18)
                                        .padding(6)
                                        .background(selectedCategory.id == category.id ? Color.white : Color.clear)
                                        .clipShape(Circle())
                                    
                                    Text(category.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(selectedCategory.id == category.id ? .white : .black)
                                }
                                .padding(.vertical,12)
                                .padding(.horizontal)
                                .background(selectedCategory.id == category.id ? Color.red : Color.gray.opacity(0.06))
                                .clipShape(Capsule())
//                                shadows...
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        selectedCategory = category
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    HStack{
                        Text("Popular Now")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action:{
                            
                        },label:{
                            HStack(spacing: 6){
                                
                                Text("View All")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.pink)
                                
                                Image(systemName: "chevron.right")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .padding(.vertical,4)
                                    .padding(.horizontal,6)
                                    .background(Color.pink)
                                    .cornerRadius(5)
                            }
                        })
                    }
                    .padding()
                    .padding(.top,10)
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        
                        HStack(spacing: 25){
                            
                            ForEach(popular_Items){ item in
                                PopularItemRowViewFoodOrderingAppUI(item: item)
                            }
                        }
                        .padding()
                        .padding(.leading,10)
                    }
                }
                .padding(.vertical)
            }
        }
            .background(Color.black.opacity(0.03).ignoresSafeArea())
    }
}

struct LandingPageFoodOrderingAppUI_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageFoodOrderingAppUI()
    }
}
