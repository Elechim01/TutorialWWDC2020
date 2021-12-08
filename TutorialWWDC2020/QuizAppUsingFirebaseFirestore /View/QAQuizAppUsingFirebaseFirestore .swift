//
//  QAQuizAppUsingFirebaseFirestore .swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/12/21.
//

import SwiftUI

struct QAQuizAppUsingFirebaseFirestore_: View {
    
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    var set : String
    @StateObject var data = QuestionViewModelQuizAppUsingFirebaseFirestore_()
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        
        ZStack{
            if data.questions.isEmpty{
                ProgressView()
            }else{
                
                if answered == data.questions.count{
                    VStack(spacing: 25){
                        Image("p1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 250)
                        
                        Text("Well Done !!!")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
//                        Score And Back to Home Button..
                        
                        HStack(spacing: 15){
                            Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                            
                            Text("\(correct)")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            
                            Image(systemName: "xmark")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                                .padding(.leading)
                            
                            Text("\(wrong)")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                        
                        Button {
//                            closing sheet...
                            present.wrappedValue.dismiss()
                        } label: {
                            Text("Goto Home")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color.blue)
                                .cornerRadius(15)
                        }

                    }
                }else{
                    VStack{
                        //         Top Progress View...
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                            
                            Capsule()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 6)
                            
                            Capsule()
                                .fill(Color.green)
                                .frame(width: progress(), height: 6)
                        }
                        .padding()
                        
                        //        Correct And Wrong Count...
                        HStack{
                            
                            Label {
                                Text(correct == 0 ? "" : "\(correct)")
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                            } icon: {
                                Image(systemName: "checkmark")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                            }
                            
                            Spacer()
                            
                            Label {
                                Text(wrong == 0 ? "" : "\(wrong)")
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                            } icon: {
                                Image(systemName: "xmark")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        
            //            Question View...
                        ZStack{
                            ForEach(data.questions.reversed().indices){ index in
            //                    View...
                                QuestionViewQuizAppUsingFirebaseFirestore_(question: $data.questions[index], correct: $correct, wrong: $wrong, answered: $answered)
    //                            if current question is completed means moving away...
                                    .offset(x: data.questions[index].completed ? 1000 : 0)
                                    .rotationEffect(.init(degrees: data.questions[index].completed ? 10 : 0))
                            }
                        }
                        .padding()
                    }
                }
            }
        }
//        fetching...
        .onAppear {
            data.getQuestions(set: set)
        }
    }
    
//    Progresss...
    func progress() -> CGFloat {
        
        let fraction = CGFloat(answered) / CGFloat(data.questions.count)
        
        let width = UIScreen.main.bounds.width - 30
        
        return fraction * width
        
    }
}

