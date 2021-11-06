//
//  HomeSmoothCurves.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 04/11/21.
//

import SwiftUI

struct HomeSmoothCurves: View {
    @State var search = ""
    @State var detail = false
    @State var isSmallDevice = UIScreen.main.bounds.width < 750
    var body: some View{
        VStack{
            
            ZStack {
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.title)
                            .foregroundColor(.black)
                    }

                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image("p1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                    }

                }
                
                HStack(spacing: 10){
                    Text("Top Choice")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(.gray)
                }
            }
            .padding([.horizontal,.top])
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    VStack(spacing: 10){
                        HStack(spacing: 12){
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.black)
                            TextField("Find something tasty", text: $search)
                        }
                        
                        Divider()
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Party Donut")
                                .font(isSmallDevice ? .title2 : .title)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            
                            Text("Every favourite donut in new glaze")
                                .font(isSmallDevice ? .caption : .none)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black.opacity(0.6))
                                
                            Button {
                                detail.toggle()
                            } label: {
                                HStack(spacing: 10){
                                    Text("Find out")
                                        .fontWeight(.heavy)
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .heavy))
                                }
                                .foregroundColor(.black)
                            }

                        }
                        .padding(.top,30)
                        .padding(.leading)
                        Image("g1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 180)
                            .clipShape(Circle())
                            .offset(x: 15, y: -15)
                    }
                    .padding()
                    .background(Color.purple
                                    .cornerRadius(30)
                                    .padding(.bottom,30)
                                    .padding(.top,30))
                    .padding(.top)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15),count: 2),spacing: 20) {
                        
                        ForEach(items){ item in
                            ItemViewSmoothCurves(item: item)
                        }
                    }
                    .padding(.top,10)
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $detail) {
            ViewDetailSmoothCurves()
        }
    }
}

struct HomeSmoothCurves_Previews: PreviewProvider {
    static var previews: some View {
        HomeSmoothCurves()
    }
}
