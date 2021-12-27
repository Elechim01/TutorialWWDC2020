//
//  LoginLoginPageUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 27/12/21.
//

import SwiftUI

struct LoginLoginPageUI: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack{
            
            Text("Sing In")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
//            Letter Spacing..
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
//            Email And Password...
            VStack(alignment: .leading, spacing: 8) {
                
                Text("User Name")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("morotto91@outllok.it", text: $email)
//                Increasing font Size And Cahnging Text Color..
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.top,5)
                
                Divider()
            }
            .padding(.top,25)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("12345", text: $password)
//                Increasing font Size And Cahnging Text Color..
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.top,5)
                
                Divider()
            }
            .padding(.top,20)
            
//            Forget Password....
            Button {
                
            } label: {
                Text("Forgot password?")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
//            this line will redice the use of unwanted hstack and spcers....
//            Try to use this and reduce the code in SwiftUI :))))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top,10)
            
//            Next Button....
            Button {
                
            } label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(Circle())
//                Shadow...
                    .shadow(color: Color.blue.opacity(0.6), radius: 5, x: 0, y: 0)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top,10)


        }
        .padding()
    }
}

struct LoginLoginPageUI_Previews: PreviewProvider {
    static var previews: some View {
        LoginLoginPageUI()
    }
}
