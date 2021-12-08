//
//  AnimatedSplashScreenWithLoginPageUIView.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 06/12/21.
// Setting background color launch app -> Info.plist -> Launch Screen -> Backgroundcolor indicare il nome colore

import SwiftUI
import Lottie

struct AnimatedSplashScreenWithLoginPageUIView: View {
    var body: some View {
        SplashScreenAnimatedSplashScreenWithLoginPageUIView()
    }
}

struct AnimatedSplashScreenWithLoginPageUIView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedSplashScreenWithLoginPageUIView()
    }
}

struct SplashScreenAnimatedSplashScreenWithLoginPageUIView: View {
    
    @State var show = false
    
//    Login Detail...
    @State var phNo = ""
    
    var body: some View{
        VStack{
            ZStack {
                
                Color.white.opacity(0.4)
                    .ignoresSafeArea()
                
                VStack {
                    AnimatedViewSplashScreenWithLoginPageUIView(show: $show)
//                    default Frame...
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .padding(.bottom,-35)
                    
                    VStack{
                        
                        HStack{
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Login")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                
                                Text("Enter your phone number to continue")
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer(minLength: 15)
                        }
                        
                        VStack {
                            HStack(spacing: 15){
                                
                                Text("+1")
                                    .foregroundColor(.black)
                                
                                Rectangle()
                                    .fill(Color.white.opacity(0.4))
                                    .frame(width: 1, height: 18)
                                
                                TextField("",text: $phNo)
                            }
                            
                            Divider()
                                .background(Color.white.opacity(0.4))
                        }
                        .padding(.vertical)
                        
                        Button {
                            
                        } label: {
                            Text("Verify Your Number")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical,10)
                                .frame(width: UIScreen.main.bounds.width - 60)
                                .background(Color.white.opacity(0.4))
                                .clipShape(Capsule())
                        }
                        
                        HStack{
                            Rectangle()
                                .fill(Color.black.opacity(0.3))
                                .frame(height: 1)
                            
                            Text("OR")
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.3))
                            Rectangle()
                                .fill(Color.black.opacity(0.3))
                                .frame(height: 1)

                        }
                        .padding(.vertical)
                            
                        HStack(spacing: 20){
                            Button {
                                
                            } label: {
                                HStack(spacing: 10){
                                    
                                    Image("fb")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                    
                                    Text("Facebook")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding(.vertical,10)
                                .frame(width: (UIScreen.main.bounds.width - 80) / 2)
                                .background(Color.blue)
                                .clipShape(Capsule())
                            }
                            Button {
                                
                            } label: {
                                HStack(spacing: 10){
                                    
                                    Image("google")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                    
                                    Text("Google")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding(.vertical,10)
                                .frame(width: (UIScreen.main.bounds.width - 80) / 2)
                                .background(Color.white)
                                .clipShape(Capsule())
                            }

                        }

                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding()
                    
//                    Bottom To up Transition...
                    
//                    we can archieve this by frame property...
                    .frame(height: show ? nil : 0)
                    .opacity(show ? 1 : 0)
                }
            }
        }
    }
}

// Animated View

struct AnimatedViewSplashScreenWithLoginPageUIView: UIViewRepresentable {
    
    @Binding var show: Bool
    func makeUIView(context: Context) -> AnimationView {
        let view = AnimationView(name: "splash1", bundle: Bundle.main)
        
        view.play { status  in
            if status{
//                toggling view...
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                    show.toggle()
                }
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
        
    }
}
