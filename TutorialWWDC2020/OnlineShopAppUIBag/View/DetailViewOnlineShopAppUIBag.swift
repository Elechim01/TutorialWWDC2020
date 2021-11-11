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
    
    @State var count = 0
    
    @State var isSmallDevice = UIScreen.main.bounds.height < 750
    
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
            .zIndex(1)
            
            VStack{
                ScrollView(isSmallDevice ? .vertical : .init(), showsIndicators: false) {
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Color")
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 15){
                                ColorButtonOnlineShopAppUIBag(color: Color.blue, selectedColor: $selectedColor)
                                ColorButtonOnlineShopAppUIBag(color: Color.blue, selectedColor: $selectedColor)
                                ColorButtonOnlineShopAppUIBag(color: Color.blue, selectedColor: $selectedColor)
                            }
                        }
                        Spacer(minLength: 0)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Size")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Text("12 cm")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, isSmallDevice ? 0 : -20)
                    
                    Text("Whether you are heading to work or traveling, a trendy handbag or clucth will add....")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    HStack(spacing: 20){
                        Button {
                            if count > 0{
                                count -= 1
                            }
                        } label: {
                            
                            Image(systemName: "minus")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .frame(width: 35, height: 35)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray,lineWidth: 1))
                        }
                        
                        Text("\(count)")
                            .font(.title2)
                        
                        Button {
                            count += 1
                        } label: {
                            
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .frame(width: 35, height: 35)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray,lineWidth: 1))
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "suit.heart.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.red)
                                .clipShape(Circle())
                        }


                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Text("BUY NOW")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }
                    .padding(.top)
                    .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
                }

            }
            .background(Color.white
                            .clipShape(CustomCornerOnlineShopAppUIBag())
                            .padding(.top, isSmallDevice ? -60 : -100)
            )
            .zIndex(0)
        }
        .background(Color.blue.ignoresSafeArea(.all,edges: .top))
        .background(Color.white.ignoresSafeArea(.all,edges: .bottom))
        .onAppear {
//            first Color Is Image Or Bag Color...
            selectedColor = Color.blue
        }
    }
}
