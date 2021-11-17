//
//  RegisterLoginPageUIWithCustomViewModifiers.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 16/11/21.
//

import SwiftUI

struct RegisterLoginPageUIWithCustomViewModifiers: View {
    
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @State var number = ""
    
    @Binding var show : Bool
    
    @Namespace var animation
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                
                HStack{
                    
                    Button {
                        withAnimation {
                            self.show.toggle()
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }

                    
                    Spacer()
                }
                .padding()
                .padding(.leading)
                
                HStack{
                    Text("Create Account")
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.leading)
                
                CustomTextFeldLoginPageUIWithCustomViewModifiers(image: "person", title: "FULL NAME", value: $name, animation: animation)
                
                CustomTextFeldLoginPageUIWithCustomViewModifiers(image: "envelope", title: "EMAIL", value: $email, animation: animation)
                    .padding(.top,5)
                
                CustomTextFeldLoginPageUIWithCustomViewModifiers(image: "lock", title: "PASSWORD", value: $name, animation: animation)
                    .padding(.top,5)
                
                CustomTextFeldLoginPageUIWithCustomViewModifiers(image: "phone.fill", title: "PHONE NUMBER", value: $number, animation: animation)
                    .padding(.top,5)
                
                HStack{
                    Spacer()
                    
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
                .padding()
                .padding(.top)
                .padding(.trailing)
                
                HStack{
                    Text("Already have a account?")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Button {
                        show.toggle()
                    } label: {
                        Text("sign in")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("yellow"))
                    }

                }
                .padding()
                .padding(.top,10)
                
                Spacer(minLength: 0)
            }
        }
       
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

