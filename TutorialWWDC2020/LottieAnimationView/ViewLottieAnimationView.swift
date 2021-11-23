//
//  ViewLottieAnimationView.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/11/21.
//

import SwiftUI
import Lottie

struct ViewLottieAnimationView: View {
    var body: some View {
        HomeViewLottieAnimationView()
    }
}

struct ViewLottieAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ViewLottieAnimationView()
    }
}

struct HomeViewLottieAnimationView: View {
    var body: some View{
        NavigationView{
            NavigationLink {
                CartPageViewLottieAnimationView()
            } label: {
                Label {
                    Text("Goto Cart Page")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                } icon: {
                    
                    Image(systemName: "cart")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(Color.orange)
                }

            }
            .navigationTitle("Home")

        }
    }
}

struct CartPageViewLottieAnimationView: View {
    
//    for dark mode
    @State var black = Color.primary.opacity(0.7)
    @Environment(\.presentationMode) var present
    
    var body: some View{
        VStack{
            
            HStack{
                
                Button {
                    present.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 24, weight: .heavy))
                        .foregroundColor(black)
                }

                
                Spacer()
            }
            .padding()
            
            LottieViewLottieAnimationView(animationName: "emptycart")
//            default Frame you can use your own height and width...
                .frame(height: UIScreen.main.bounds.height / 2)
            
            Text("your Cart is Empty")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(black)
            
            Text("Load up that basket with some yummy fruits")
                .fontWeight(.bold)
                .foregroundColor(black)
                .padding(.top,5)
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Text("Start Shopping")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(Color.orange)
                    .cornerRadius(4)
            }
            .padding(.bottom,10)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

// Lottie Animation View....

struct LottieViewLottieAnimationView: UIViewRepresentable {
    var animationName: String
    
    func makeUIView(context: Context) -> AnimationView {
        
        let view = AnimationView(name: animationName, bundle: Bundle.main)
        
//        there are lot of options are available for customization....
//        im going to use only play and loop...
//        you can use your own...
        view.loopMode = .loop
        view.play()
        
        return view
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
        
    }
}
