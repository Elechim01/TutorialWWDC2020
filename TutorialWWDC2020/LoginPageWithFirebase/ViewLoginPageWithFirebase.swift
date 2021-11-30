//
//  ViewLoginPageWithFirebase.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 28/11/21.
//

import SwiftUI
import Firebase

struct ViewLoginPageWithFirebase: View {
    @AppStorage("log_Status") var status = false
    var body: some View {
        ZStack{
            if status{
               HomeViewLoginPageWithFirebase()
            }else{
                NavigationView{
                    LoginPageWithFirebase()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
       
    }
}

struct ViewLoginPageWithFirebase_Previews: PreviewProvider {
    static var previews: some View {
        ViewLoginPageWithFirebase()
    }
}

struct HomeViewLoginPageWithFirebase: View {
    @AppStorage("log_Status") var status = false
    var body: some View{
        VStack(spacing: 15){
//                    Home View...
            Text("Logged In Successfully")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Button {
//                logging out...
                try! Auth.auth().signOut()
                withAnimation {
                    status = false
                }
            } label: {
                Text("LogOut")
                    .fontWeight(.heavy)
            }

        }
    }
}
