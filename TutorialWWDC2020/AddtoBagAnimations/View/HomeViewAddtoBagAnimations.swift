//
//  HomeViewAddtoBagAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 20/12/21.
//

import SwiftUI

struct HomeViewAddtoBagAnimations: View {
    
    @StateObject var homeData = HomeViewModelAddtoBagAnimations()
    
    @Namespace var animation
    
    var body: some View {
        
        ZStack(alignment: .bottom){
//                Home View...
            VStack(spacing: 15){
                
                HStack{
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "rectangle.3.offgrid.fill")
                            .font(.title2)
                            .foregroundColor(.black)
                    }

                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bag.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.purple)
                            .clipShape(Circle())
                            .overlay(
                                Text("\(homeData.cartItems)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.orange)
                                    .clipShape(Circle())
                                    .offset(x: 15, y: -10)
                                    .opacity(homeData.cartItems != 0 ? 1 : 0)
                            )
                    }

                }
                .overlay(
                    Text("Nike")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                )
                .padding()
                
                ScrollView{
//                    Shoe Cards...
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Air Max Exosense 'Atomic Powder'")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Text("Nike")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal,30)
                    
                    Text("Price")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Text("$270.00")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.orange)
                }
                    .padding(.horizontal)
                    .padding(.vertical,20)
                    .background(Color.black.opacity(0.06))
                    .cornerRadius(20)
                    .overlay(
                        Capsule()
                            .fill(Color.purple)
                            .frame(width: 4, height: 45)
                            .padding(.top,25)
                        
                        ,alignment: .topLeading
                    )
                    .padding()
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            homeData.showCart.toggle()
                        }
                    }
                }
            }
//            Bluring when cart is opened...
            .blur(radius: homeData.showCart ? 50 : 0)
            
            AddToCartAddtoBagAnimations(animation: animation)
//            hiding view when shoe is not selected...
//            like Bottom Sheet..
//            also closing when animation started...
                .offset(y: homeData.showCart ? homeData.startAnimation ? 500 : 0 : 500)
//            setting enviroment object so as to access it easier...
                .environmentObject(homeData)
            
//            Animations...
            if homeData.startAnimation{
                
                VStack{
                
                    Spacer()
                    
                    ZStack{
                        
//                        Circle Animation Effect..
                        Color.white
                            .frame(width: homeData.showAnimation ? 100 : getRectAddtoBagAnimations().width * 1.3,
                                   height: homeData.showAnimation ? 100 : getRectAddtoBagAnimations().width * 1.3)
                            .clipShape(Circle())
//                        Opacity...
                            .opacity(homeData.showAnimation ? 1 : 0)
                        
                        Image("p1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "SHOE", in: animation)
                            .frame(width: 80, height: 80)
                    }
                    .offset(y: homeData.saveCart ? 70 :  -120)
//                    scaling effect..
                    .scaleEffect(homeData.saveCart ? 0.6 : 1)
                    .onAppear {
                        homeData.performAnimations()
                    }
                    
                    if !homeData.saveCart{
                        Spacer()
                    }
                    
                    Image(systemName: "bag\(homeData.additemtocart ? ".fill" : "")")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(homeData.additemtocart ? Color.purple :  Color.orange)
                        .clipShape(Circle())
                        .offset(y: homeData.showBag ? -50 : 300)
                    
                }
//                setting external view width to screen width...
                .frame(width: getRectAddtoBagAnimations().width)
                .offset(y: homeData.endAnimation ? 500 : 0)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.04).ignoresSafeArea())
//        listening to end Animation and revertig back all..
        .onChange(of: homeData.endAnimation) { value in
            
            if homeData.endAnimation{
//                    reset...
                homeData.resetAll()
            }
        }
    }
}

struct HomeViewAddtoBagAnimations_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewAddtoBagAnimations()
    }
}

// Add to cart View...

struct AddToCartAddtoBagAnimations: View{
    
    @EnvironmentObject var homeData: HomeViewModelAddtoBagAnimations
    var animation: Namespace.ID
    
    var body: some View{
        
        VStack{
            
            HStack(spacing: 15){
                
                if !homeData.startAnimation{
                    
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "SHOE", in: animation)

                }
                
                VStack(alignment: .trailing, spacing: 10) {
                    Text("Air Max Exosense 'Atomic Powder'")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                    
                    Text("$270.00")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                }
            }
            .padding()
            
            Divider()
            
            Text("SELECT SIZE")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.vertical)
            
//            Size...
            let columns = Array(repeating: GridItem(.flexible(),spacing: 8), count: 4)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
                
                ForEach(sizeAddtoBagAnimations,id:\.self){ size in
                    Button {
                        withAnimation {
                            homeData.selectedSize =  size
                        }
                    } label: {
                        Text(size)
                            .fontWeight(.semibold)
                            .foregroundColor(homeData.selectedSize == size ? .white : .black)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(homeData.selectedSize == size ? Color.orange :  Color.black.opacity(0.06))
                            .cornerRadius(10)
                    }

                }
            }
            .padding(.top)
            
//            Add to cart Button...
            Button {
                withAnimation(.easeInOut(duration: 0.7)){
                    homeData.startAnimation.toggle()
                }
            } label: {
                Text("Add to cart")
                    .fontWeight(.bold)
                    .foregroundColor(homeData.selectedSize == "" ? .black : .white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(homeData.selectedSize == "" ? Color.black.opacity(0.06) : Color.orange)
                    .cornerRadius(18)
            }
//            disabling button when no size selected...
            .disabled(homeData.selectedSize == "")
            .padding(.top)

            
        }
        .padding()
        .background(Color.white.clipShape(CustomCornersViewAddtoBagAnimations(corners: [.topLeft,.topRight], radius: 35)))
    }
}

let sizeAddtoBagAnimations = ["EU 40","EU41","EU42","EU43","EU44"]

// extending view to get Screen size...

extension View{
    
    func getRectAddtoBagAnimations()->CGRect{
        return UIScreen.main.bounds
    }
    
}
