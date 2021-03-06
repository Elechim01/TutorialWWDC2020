//
//  ViewQuizAppUsingFirebaseFirestore .swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/12/21.
//

import SwiftUI

struct ViewQuizAppUsingFirebaseFirestore_: View {
    var body: some View {
        HomeViewQuizAppUsingFirebaseFirestore_()
    }
}

struct ViewQuizAppUsingFirebaseFirestore__Previews: PreviewProvider {
    static var previews: some View {
        ViewQuizAppUsingFirebaseFirestore_()
    }
}

struct HomeViewQuizAppUsingFirebaseFirestore_:View {
    
    @State var show = false
//  Storing Level For Fetching Questions...
    @State var set = "Round_1"
    
//    for analytics..
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    
    var body: some View{
        VStack{
            Text("Michele")
                .font(.system(size: 38))
                .fontWeight(.heavy)
                .foregroundColor(.purple)
                .padding(.top)
            
            Text("Choose the way \nyou play !!!")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.top,8)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 0)
//            Level View...
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 20), count: 2),spacing: 30) {
                
//                four levels...
                ForEach(1...4,id:\.self){ index in
                    VStack(spacing: 15){
                        Image("g\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 150)

                        
                        Text("SwiftUI Quiz")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        Text("LEVEL \(index)")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
//                    opening QA view as sheet...
                    .onTapGesture {
                        set = "Round_\(index)"
                        show.toggle()
                    }
                }
            }
            .padding()
            
            Spacer(minLength: 0)
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea())
        .sheet(isPresented: $show) {
            QAQuizAppUsingFirebaseFirestore_(correct: $correct, wrong: $wrong,answered: $answered,set: set)
        }
    }
}
