//
//  ViewLoginPageUIWithCustomViewModifiers.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/11/21.
//

import SwiftUI

struct ViewLoginPageUIWithCustomViewModifiers: View {
    
    var body: some View {
        
        NavigationView{
            LoginViewLoginPageUIWithCustomViewModifiers()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct ViewLoginPageUIWithCustomViewModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ViewLoginPageUIWithCustomViewModifiers()
    }
}

struct LoginViewLoginPageUIWithCustomViewModifiers: View {
    
    @State var email = ""
    @State var password = ""
    @Namespace var animation
    
    @State var show = false
    
    var body: some View {
        VStack{
            
            Spacer(minLength: 0)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Login")
                        .font(.system(size: 40, weight: .heavy))
    //                For Dark Mode Adopton...
                        .foregroundColor(.primary)
                    
                    Text("Please sign in to continue")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.leading)
            
            CustomTextFeldLoginPageUIWithCustomViewModifiers(image: "envelope", title: "EMAIL", value: $email, animation: animation)
            
            CustomTextFeldLoginPageUIWithCustomViewModifiers(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                .padding(.top,5)
            
            HStack {
                
                Spacer(minLength: 0)
                
                VStack(alignment: .trailing, spacing: 20) {
                    Button {
                        
                    } label: {
                        Text("FORGOT")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("yellow"))
                    }
                    Button {
                        
                    } label: {
                        HStack{
                            Text("SIGN UP ")
                                .fontWeight(.heavy)
                            
                            Image(systemName: "arrow.right")
                                .font(.title2)
                        }
                        .modifier(CustomButtonModifierLoginPageUIWithCustomViewModifiers())
                    }
                    


                }
            }
            .padding()
            .padding(.top,10)
            .padding(.trailing)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 8){
                Text("Don't have an account?")
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)

                
                NavigationLink(isActive: $show) {
                    RegisterLoginPageUIWithCustomViewModifiers(show: $show)
                } label: {
                    Text("sign up")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("yellow"))
                }

            }
            .padding()
        }
    }
}
