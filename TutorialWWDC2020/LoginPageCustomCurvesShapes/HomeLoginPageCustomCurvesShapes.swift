//
//  HomeLoginPageCustomCurvesShapes.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 16/09/21.
//

import SwiftUI

struct HomeLoginPageCustomCurvesShapes: View {
    
    @State var signUp = false
    @State var user = ""
    @State var pass = ""
    @State var rePass = ""
    
    var body: some View {
        ZStack{
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)){
                    Color("Color2")
                        .clipShape(CShape())
                    //                adding another curve...
                    Path{ path in
                        //                    adding 40 for center...
                        path.addArc(center: CGPoint(x: UIScreen.main.bounds.width - 120, y: UIScreen.main.bounds.height - 50),
                                    radius: 40, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
                    }
                    .fill(Color.white)
                    
                    //                adding Buttons...
                    
                    Button(action: {
                        withAnimation(.easeInOut){
                            self.signUp = false
                        }
                        
                    }, label: {
                        Image(systemName: signUp ? "xmark" : "person.fill")
                            .font(.system(size: 23,weight: .bold))
                            .foregroundColor(Color("Color"))
                    })
                    .offset(x: -110, y: -50)
//                    disabiling Button When its not Use..
                    .disabled(signUp ? false : true)
                    
                    Button(action: {
                        
                        withAnimation(.easeIn){
                            self.signUp = true
                        }
                    }, label: {
                        Image(systemName: signUp ? "person.fill.badge.plus": "xmark")
                            .font(.system(size:signUp ? 26 : 25,weight: .bold))
                            .foregroundColor(.white)
                    })
                    .offset(x: -30, y: -40)
                    .disabled(signUp ? true : false)
                }
                
                //                Login View...
                VStack(alignment: .leading, spacing: 25){
                    Text("Login")
                        .font(.system(size: 35,weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Username")
                        .foregroundColor(.white)
                        .padding(.top,10)
                    
                    VStack{
                        
                        TextField("Username",text: $user)
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                    }
                    
                    Text("Password")
                        .foregroundColor(.white)
                        .padding(.top,10)
                    
                    VStack{
                        
                        SecureField("Password",text: $pass)
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                    }
                    HStack{
                        Spacer()
                        
                        //                      Login Button...
                        Button(action: {}, label: {
                            Text("Login")
                                .fontWeight(.bold)
                                .foregroundColor(Color("Color2"))
                                .padding(.vertical)
                                .padding(.horizontal,45)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        Spacer()
                    }
                    .padding(.top)
                    Spacer(minLength: 0)
                }
                .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 120)
                .padding()
            }
            //            Moving View up...
            //            Adjusting For Iphone 8 Like Model...
            .offset(y:signUp ? -UIScreen.main.bounds.height + (UIScreen.main.bounds.height < 750 ? 100 : 130) : 0)
            .zIndex(1)
//            Moving View Fron In Stck...
            
            //       SingUp View..
            VStack(alignment: .leading, spacing: 25){
                Text("Sing Up")
                    .font(.system(size: 35,weight: .bold))
                    .foregroundColor(Color("Color2"))
                
                Text("Username")
                    .foregroundColor(Color("Color2"))
                    .padding(.top,10)
                
                VStack{
                    
                    TextField("Username",text: $user)
                    
                    Divider()
                        .background(Color("Color2").opacity(0.5))
                }
                
                Text("Password")
                    .foregroundColor(Color("Color2"))
                    .padding(.top,10)
                
                VStack{
                    
                    SecureField("Password",text: $pass)
                    
                    Divider()
                        .background(Color("Color2").opacity(0.5))
                }
                
                Text("Re-Enter")
                    .foregroundColor(Color("Color2"))
                    .padding(.top,10)
                
                VStack{
                    
                    SecureField("Re-Enter",text: $rePass)
                    
                    Divider()
                        .background(Color("Color2").opacity(0.5))
                }
                HStack{
                    Spacer()
                    
                    //                      Login Button...
                    Button(action: {}, label: {
                        Text("Sing Up")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal,45)
                            .background(Color("Color2"))
                            .clipShape(Capsule())
                    })
                    Spacer()
                }
                .padding(.top)
                Spacer(minLength: 0)
            }
            .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 50)
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .preferredColorScheme(signUp ? .light : .dark)
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
    }
}

struct HomeLoginPageCustomCurvesShapes_Previews: PreviewProvider {
    static var previews: some View {
        HomeLoginPageCustomCurvesShapes()
    }
}
//Custom Shape...
struct CShape : Shape {
    func path(in rect: CGRect) -> Path {
        return Path{ path in
//            starting from bottom..
            path.move(to: CGPoint(x: rect.width, y: rect.height - 50))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height - 50))
            
//            adding curve...
            path.addArc(center:  CGPoint(x: rect.width - 40, y: rect.height - 50), radius: 40, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: false)
        }
    }
}
