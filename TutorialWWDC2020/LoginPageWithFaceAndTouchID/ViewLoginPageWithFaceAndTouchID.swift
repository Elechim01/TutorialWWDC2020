//
//  ViewLoginPageWithFaceAndTouchID.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 01/11/21.
//Color1,Color2

import SwiftUI
import LocalAuthentication

struct ViewLoginPageWithFaceAndTouchID: View {
    @AppStorage("Status") var logged = false
    var body: some View {
        NavigationView{
            if logged{
                Text("User Logged in...")
                    .navigationTitle("Home")
                    .navigationBarHidden(false)
                    .preferredColorScheme(.light)
            }else{
                HomeoginPageWithFaceAndTouchID()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ViewLoginPageWithFaceAndTouchID_Previews: PreviewProvider {
    static var previews: some View {
        ViewLoginPageWithFaceAndTouchID()
    }
}

struct HomeoginPageWithFaceAndTouchID:View {
    @State var userName = ""
    @State var password = ""
    @AppStorage("stored_User") var user = "morotto91@outlook.it"
    @AppStorage("status") var logged = false
    var body: some View{
        VStack{
            
            Spacer(minLength: 0)
            
            Image("g1")
                .resizable()
                .aspectRatio(contentMode: .fit)
//            Dynamic Frame...
             
                .frame(width: 250, height: 200)
                .padding(.vertical)
            
            HStack{
                VStack(alignment: .leading, spacing: 12) {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Please sing in to continue..")
                        .foregroundColor(Color.white.opacity(0.5))
                }
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.leading,15)
            
            HStack{
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                TextField("EMAIL",text: $userName)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            
            HStack{
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                SecureField("PASSWORD",text: $password)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(password == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)
            
            HStack(spacing: 15){
                Button {
                    
                } label: {
                    Text("Login")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color("Color1"))
                        .clipShape(Capsule())
                }
                .opacity(userName != "" && password != "" ? 1 : 0.5)
                .disabled(userName != "" && password != "" ? false : true)
                if getBioMetricStatus(){
                    Button {
                        authenticateUser()
                    } label: {
//                        getting biometrictype..
                        Image(systemName: LAContext().biometryType == .faceID ? "faceid": "touchid")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color("Color1"))
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.top)
            
//            Forget Button...
            Button {
                
            } label: {
                Text("Forget password?")
                    .foregroundColor(Color("Color1"))
            }
            .padding(.top,8)

//          SignUp...
            
            
            Spacer(minLength: 0)
            
            HStack(spacing: 5){
                Text("Don't have an account?")
                    .foregroundColor(Color.white.opacity(0.6))
                Button {
                    
                } label: {
                    Text("Signup")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("Color1"))
                }
            }
            .padding(.vertical)
        }
        .background(Color("Color2").ignoresSafeArea(.all, edges: .all))
        .animation(.easeOut)
    }
    
//    Getting BioMetricType...
    func getBioMetricStatus() -> Bool {
        let scanner = LAContext()
        if userName == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none){
            return true
        }
        return false
    }
    
    func authenticateUser(){
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock\(userName)") { status, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            withAnimation(.easeOut){
                logged = true
            }
        }
    }
    
}
