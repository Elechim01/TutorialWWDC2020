//
//  VerificationLoginPageWithFirebase.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 29/11/21.
//

import SwiftUI

struct VerificationLoginPageWithFirebase: View {
    @ObservedObject var loginData : LoginViewModelLoginPageWithFirebase
    @Environment(\.presentationMode) var present
    var body: some View {
        
        ZStack{
            VStack {
                VStack{
                    
                    HStack{
                        Button {
                            present.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Text("Verify Phone")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if loginData.loading{
                            ProgressView()
                        }
                    }
                    .padding()
                    
                    Text("Code sent to \(loginData.phNo)")
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 15){
                        ForEach(0..<6,id:\.self) { index in
                            //                        displaying code...
                            CodeViewLoginPageWithFirebase(code: getCodeAtIndex(index: index))
                        }
                    }
                    .padding()
                    .padding(.horizontal,20)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 6){
                        Text("Didn't recive code?")
                            .foregroundColor(.gray)
                        
                        Button {
                            loginData.requestCode()
                        } label: {
                            Text("Request Again")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        
                    }
                    Button {
                        
                    } label: {
                        Text("Get via call")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding(.top,6)
                    
                    Button {
                        loginData.verifyCode()
                    } label: {
                        Text("Verify and Create Account")
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.yellow)
                            .cornerRadius(15)
                    }
                    .padding()
                    
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(Color.white)
                .cornerRadius(20)
                
                CustomNumberPadLoginPageWidthFirebase(value: $loginData.code, isVerify: true)
            }
            .background(Color.white.opacity(0.3).ignoresSafeArea(.all,edges: .bottom))
            
            if loginData.error{
                AlertViewLoginPageWithFirebasePhoneAuth(msg: loginData.errorMsg, show: $loginData.error)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
//    getting Code At Each Index...
    func getCodeAtIndex(index: Int)-> String{
        if loginData.code.count > index{
            
            let start = loginData.code.startIndex
            
            let current = loginData.code.index(start,offsetBy: index)
            
            return String(loginData.code[current])
        }
        
        return ""
    }
    
}

struct CodeViewLoginPageWithFirebase: View {
    
    var code : String
    
    var body: some View{
        VStack(spacing: 10){
            Text(code)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.title2)
//            deafult frame...
                .frame(height: 45)
            
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 4)
        }
    }
}
