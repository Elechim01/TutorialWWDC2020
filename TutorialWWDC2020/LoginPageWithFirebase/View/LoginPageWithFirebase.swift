//
//  Login.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 28/11/21.
//

import SwiftUI

struct LoginPageWithFirebase: View {
    @StateObject var loginData = LoginViewModelLoginPageWithFirebase()
    @State var isSmall = UIScreen.main.bounds.height < 750
    var body: some View {
        ZStack {
            VStack{
                VStack{
                    Text("Continue With Phone")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text("you'll recive a 4 digit code\n to verify next.")
                        .font(isSmall ? .none : .title2)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    
    //                Mobile Number Field...
                    HStack{
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Enter Your Number")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("+ \(loginData.getCountryCode()) \(loginData.phNo)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        
                        Spacer(minLength: 0)
                        
                        NavigationLink(isActive: $loginData.gotoVerify,destination: {
                            VerificationLoginPageWithFirebase(loginData: loginData)
                        }){
                            
                            Text("")
                                .hidden()
                        }
                        Button(action: {
                            loginData.sendCode()
                        }, label: {
                            Text("Continue")
                                .foregroundColor(.black)
                                .padding(.vertical,18)
                                .padding(.horizontal,38)
                                .background(Color.yellow)
                                .cornerRadius(15)
                        })
                        .disabled(loginData.phNo == "" ? true : false)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(Color.white)
                .cornerRadius(20)
                
    //           Custom Number pad...
                CustomNumberPadLoginPageWidthFirebase(value: $loginData.phNo, isVerify: false)
            }
            .background(Color("bg").ignoresSafeArea(.all,edges: .bottom))
            
            if loginData.error{
                AlertViewLoginPageWithFirebasePhoneAuth(msg: loginData.errorMsg, show: $loginData.error)
            }
        }
    }
    
}

