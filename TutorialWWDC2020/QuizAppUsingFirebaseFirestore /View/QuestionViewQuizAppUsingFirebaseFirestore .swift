//
//  QuestionViewQuizAppUsingFirebaseFirestore .swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/12/21.
//

import SwiftUI
import Lottie

struct QuestionViewQuizAppUsingFirebaseFirestore_: View {
    
    @Binding var question: QuestionQuizAppUsingFirebaseFirestore_
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    
    @State var selected = ""
    
    var body: some View {
        VStack(spacing: 22){
            Text(question.question!)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.top,25)
            
            Spacer(minLength: 0)
            
//            Options...
            
            Button {
                selected = question.optionA!
            } label: {
                Text(question.optionA!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionA!),lineWidth: 1)
                    )
            }
            
            Button {
                selected = question.optionB!
            } label: {
                Text(question.optionB!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionB!),lineWidth: 1)
                    )
            }
            Button {
                selected = question.optionC!
            } label: {
                Text(question.optionC!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color(option: question.optionC!),lineWidth: 1)
                    )
            }
            
            Spacer(minLength: 0)
            
//            Buttons...
            
            HStack(spacing: 15){
                Button {
                    checkAns()
                } label: {
                    Text("Submit")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
//                disabling...
                .disabled(question.isSubmitted ? true: false)
                .opacity(question.isSubmitted ? 0.7 : 1)
                
                Button {
                    withAnimation {
                        question.completed.toggle()
                        answered += 1
                    }
                } label: {
                    Text("Next")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                .disabled(!question.isSubmitted ? true: false)
                .opacity(!question.isSubmitted ? 0.7 : 1)
            }
            .padding(.bottom)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
    }
    
    func color(option: String)->SwiftUI.Color{
        if option == selected{
            
//            displaying if correct means green else red...
            if question.isSubmitted{
                if selected == question.answer!{
                    return Color.green
                }else{
                    return Color.red
                }
            }else{
                return Color.blue
            }
            
        }else{
            
//            displaying right if wrong selected...
            
            if question.isSubmitted && option != selected{
                if question.answer! == option{return Color.green}
            }
            
            return Color.gray
        }
    }
    
//    check answer...
    func checkAns(){
        if selected == question.answer!{
            correct += 1
        }else{
            wrong += 1
        }
        
        question.isSubmitted.toggle()
    }
    
}

struct QuestionViewQuizAppUsingFirebaseFirestore__Previews: PreviewProvider {
    static var previews: some View {
        ViewQuizAppUsingFirebaseFirestore_()
    }
}
