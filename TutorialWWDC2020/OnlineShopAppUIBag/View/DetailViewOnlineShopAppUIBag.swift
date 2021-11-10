//
//  DetailViewOnlineShopAppUIBag.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 09/11/21.
//

import SwiftUI

struct DetailViewOnlineShopAppUIBag: View {
    
    @Binding var bagData : BagModel!
    @Binding var show: Bool
    var animation: Namespace.ID
//    Initalization...
    @State var selectedColor = Color.red
    
    var body: some View {
        VStack{
            
            HStack{
                
                VStack(alignment: .leading,spacing: 5) {
                    Button {
                        withAnimation(.easeOut){
                            show.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Text("Aristocratic Had Bag")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    Text(bagData.title)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                }
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
            }
            .padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            HStack(spacing: 10){
                VStack(alignment: .leading, spacing: 6) {
                    Text("Price")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text(bagData.price)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                Image(bagData.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                Hero Animation...
                    .matchedGeometryEffect(id: bagData.image, in: animation)
            }
            .padding()
            .padding(.top,10)
            
            VStack{
                
                HStack{
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Color")
                            .foregroundColor(.gray)
                        HStack(spacing: 15){
                            ColorButtonOnlineShopAppUIBag(color: Color.blue, selectedColor: $selectedColor)
                            ColorButtonOnlineShopAppUIBag(color: Color.blue, selectedColor: $selectedColor)
                            ColorButtonOnlineShopAppUIBag(color: Color.blue, selectedColor: $selectedColor)
                        }
                    }
                }
            }
        }
        .background(Color.blue.ignoresSafeArea(.all,edges: .top))
        .background(Color.white.ignoresSafeArea(.all,edges: .bottom))
        .onAppear {
//            first Color Is Image Or Bag Color...
            selectedColor = Color.blue
        }
    }
}
