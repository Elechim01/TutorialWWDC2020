//
//  ViewFacebookLogin.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 11/10/21.
//

import SwiftUI
import FBSDKLoginKit

struct ViewFacebookLogin: View {
    var body: some View {
        HomeFacebookLogin()
    }
}

struct ViewFacebookLogin_Previews: PreviewProvider {
    static var previews: some View {
        ViewFacebookLogin()
    }
}

struct HomeFacebookLogin: View {
//    setting App Storages => User Defaults..
    @AppStorage("logged") var logged = false
    @AppStorage("email") var email = ""
    @State var manager = LoginManager()
    var body: some View{
        
        VStack(spacing: 25){
//            Custom Login button...
            Button {
//                if logged means logging out...
                if logged{
                    manager.logOut()
                    email = ""
                    logged = false
                }else{
//                    cheking if user cancelled the flow...
                    
//                    logging in user...
//                    permission for reading and email
                    manager.logIn(permissions: ["public_profile","email"], from: nil) { result, err in
                        if err != nil{
                            print(err!.localizedDescription)
                            return
                        }
                        
//                        cheking if users cancelled the flow
                        if !result!.isCancelled{
                            //                        logged success...
                                                    logged = true
                            //                        getting user details using FB Graph request...
                                                    let request = GraphRequest(graphPath: "me", parameters: ["fields":"email"])
                                                    request.start { _, res, _ in
                                                        
                            //                            it will return as dictionary...
                                                        
                                                        guard let profileData = res as? [String: Any] else { return  }
                                                        
                            //                             saving email...
                                                        email = profileData["email"] as! String
                                                    }
                        }
                    }
                }
                
            } label: {
                Text(logged ? "LogOut":"FB Login")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
            
            Text(email)
                .fontWeight(.bold)
            
        }
    }
}
