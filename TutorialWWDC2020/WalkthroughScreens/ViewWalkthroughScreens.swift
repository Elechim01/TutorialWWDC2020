//
//  ViewWalkthroughScreens.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

struct ViewWalkthroughScreens: View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        
        if currentPage > totalpagesWalkthroughScreens{
            HomeViewWalkthroughScreens()
        }else{
            WalkthroughtScreenViewWalkthroughScreens()
        }
       
    }
}

struct ViewWalkthroughScreens_Previews: PreviewProvider {
    static var previews: some View {
        ViewWalkthroughScreens()
    }
}

//Home Page...
struct HomeViewWalkthroughScreens:View {
    
    var body: some View{
        
        Text("Welcome to Home!!")
            .font(.title)
            .fontWeight(.heavy)
    }
}

// Walkthrought Screen

struct WalkthroughtScreenViewWalkthroughScreens:View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View{
        
//        For Slide Animation...
        ZStack{
            
//            Changing Between Views...
            if currentPage == 1{
                ScreenViewWalkthroughScreens(image: "p1", title: "Step1", detail: "", bgColor: .orange)
                    .transition(.scale)
            }
            if currentPage == 2{
                ScreenViewWalkthroughScreens(image: "p2", title: "Step2", detail: "", bgColor: .green)
                    .transition(.scale)
            }
            if currentPage == 3{
                ScreenViewWalkthroughScreens(image: "p3", title: "Step3", detail: "", bgColor: .purple)
                    .transition(.scale)
            }
        }
        .overlay(
            
//            Button...
            Button(action: {
//                changing views...
                withAnimation(.easeInOut){
//                    checking...
                    if currentPage <= totalpagesWalkthroughScreens{
                        currentPage += 1
                    }else{
                        
//                        For App Testing only...
                        currentPage = 1
                    }
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
//                Circlular Slider...
                    .overlay(
                        ZStack{
                            
                            Circle()
                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
                              
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalpagesWalkthroughScreens))
                                .stroke(Color.white,lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
            })
            .padding(.bottom,20)
            
            ,alignment: .bottom
        )
            
    }
}

struct ScreenViewWalkthroughScreens:View {
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View{
        
        VStack(spacing: 20){
            
            HStack{
                
//           Shwoing only for first page...
                if currentPage == 1{
                    Text("Hello Member!")
                        .font(.title)
                        .fontWeight(.semibold)
    //                    Letter Spacing...
                        .kerning(1.4)
                }else{
//                  Back Button..
                    Button {
                        withAnimation(.easeInOut){
                            currentPage -= 1
                        }
                    } label: {
                        Image(systemName: "chvron.left")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    }

                }
                
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut){
                        currentPage = 4
                    }
                } label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                }
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            
            Text("Lorme ipsum is dummy")
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            
//                Minimum spacing When Phone is reducong..
            Spacer(minLength: 120)
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}

// total pages...
var totalpagesWalkthroughScreens = 3
