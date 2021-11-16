//
//  ViewLoginPageUIWithCustomViewModifiers.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/11/21.
//

import SwiftUI

struct ViewLoginPageUIWithCustomViewModifiers: View {
    var body: some View {
       LoginViewLoginPageUIWithCustomViewModifiers()
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
    
    var body: some View {
        VStack{
            
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
                        Text("LOGIN")
                            .fontWeight(.heavy)
                        
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal,35)
                    .background(
                        LinearGradient(gradient: .init(colors: [Color("yellow-light"),Color("yellow")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(Capsule())


                }
            }
            .padding()
            .padding(.top,10)
            .padding(.leading)
        }
    }
}
