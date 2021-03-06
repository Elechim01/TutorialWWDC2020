//
//  LoginViewModel.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 28/11/21.
//

import SwiftUI
import Firebase

class LoginViewModelLoginPageWithFirebase: ObservableObject {
   
    @Published var phNo = ""
    
    @Published var code = ""
//    getting country Phone Code...
    
//    DataModel For Error View...
    @Published var errorMsg = ""
    @Published var error = false
    
//    storing CODE for verifiation....
    @Published var CODE = ""
    @Published var gotoVerify = false
    
//    User Logged Status...
    @AppStorage("log_Status") var status = false
    
//    Loagin View....
    @Published var loading = false
    
    func getCountryCode()->String{
        
        let regionCode = Locale.current.regionCode ?? ""
        
        return countries[regionCode] ?? ""
    }
//    sending Code To User...
    func sendCode(){
        
//        enabling testng code...
//        disable when need to test with real device...
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let number = "+\(getCountryCode())\(phNo)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { CODE, err in
            if let error = err{
                self.errorMsg = error.localizedDescription
                withAnimation{self.error.toggle()}
                return
            }
            self.CODE = CODE ?? ""
            self.gotoVerify = true
        }
    }
    
    func verifyCode() {
        let credental = PhoneAuthProvider.provider().credential(withVerificationID:  self.CODE, verificationCode: code)
        loading = true
        
        Auth.auth().signIn(with: credental) { (result, err) in
            
            self.loading = false
            
            if let error = err{
                self.errorMsg = error.localizedDescription
                withAnimation {self.error.toggle()}
                return
            }
            
//          else user logged in Successfully....
            withAnimation {
                self.status = true
            }
            
        }
    }
    
    func requestCode(){
        sendCode()
        withAnimation {
            self.errorMsg = "Code Sent Successfully !!!"
            self.error.toggle()
        }
    }
}

