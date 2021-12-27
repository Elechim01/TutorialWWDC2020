//
//  OtpLoginFirebasePhoneAuthFirebaseStreamSDK.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 26/12/21.
//

import SwiftUI

struct OtpLoginFirebasePhoneAuthFirebaseStreamSDK: View {
    
    @EnvironmentObject var model : LoginViewModelFirebasePhoneAuthFirebaseStreamSDK
    
    var body: some View {
       
        VStack{
            
            Image("p1")
                .padding(20)
            
            HStack(spacing: 15){
                
                TextField("1", text: $model.countryCode)
                    .keyboardType(.numberPad)
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .frame(width: 50)
                    .background(
                        
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(model.countryCode == "" ? Color.gray : Color.pink,lineWidth: 1.5)
                    )
                TextField("123456789", text: $model.phNumer)
                    .keyboardType(.numberPad)
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .background(
                        
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(model.phNumer == "" ? Color.gray : Color.pink,lineWidth: 1.5)
                    )
            }
            .padding(.top,20)
            
            Button {
                model.verifyUser()
            } label: {
                Text("Login")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical,12)
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .cornerRadius(8)
            }
            .disabled(model.countryCode == "" || model.phNumer == "")
            .opacity(model.countryCode == "" || model.phNumer == "" ? 0.6 : 1)
            .padding(.top,20)

            
            Spacer()
        }
        .padding()
    }
}

struct OtpLoginFirebasePhoneAuthFirebaseStreamSDK_Previews: PreviewProvider {
    static var previews: some View {
        OtpLoginFirebasePhoneAuthFirebaseStreamSDK()
    }
}
