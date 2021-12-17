//
//  ViewCustomTagView.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 16/12/21.
//

import SwiftUI

struct ViewCustomTagView: View {
    var body: some View {
        NavigationView{
            HomeCustomTagView()
                .navigationTitle("Chips")
        }
    }
}

struct ViewCustomTagView_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomTagView()
    }
}

struct HomeCustomTagView:View {
    
    @State var text = ""
    
    @State var chips : [[ChipsDataCustomTagView]] = [
//        Sample Data For Testing...
        [ChipsDataCustomTagView(chipText: "Ciao"),ChipsDataCustomTagView(chipText: "Parole"),ChipsDataCustomTagView(chipText: "Video"),ChipsDataCustomTagView(chipText: "sci")]
    ]
    
    var body: some View{
        VStack(spacing: 35){
            
            ScrollView{
//            Chips View...
                LazyVStack(alignment: .leading,spacing: 10){
                
//                since Were using Indices So We Need To specify Id...
                ForEach(chips.indices,id:\.self){ index in
                    HStack{
                        
//                     some times it asks us to specify hashable in Data Model...
                        ForEach(chips[index].indices,id:\.self){ chipIndex in
                            Text(chips[index][chipIndex].chipText)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal)
                                .background(Capsule().stroke(Color.black,lineWidth: 1))
                                .lineLimit(1)
//                            Main Logic...
                                .overlay(
                                    GeometryReader{ reader -> Color in
                                        
//                                        By Using MaxX Parameter We Can Use Logic And determinate if its exceeds or not....
                                        let maxX = reader.frame(in: .global).maxX
                                        
//                                        Both padding = 30 + 30  = 60
//                                        Plus 10 For Extra...
                                        
//                                       Doing Action Only If the Item Exceeds....
                                        
                                        if maxX > UIScreen.main.bounds.width -  70 && !chips[index][chipIndex].isExceeded{
                                            
//                                            it is updating to each user interaction...
                                            print(chipIndex)
                                            
                                            DispatchQueue.main.async {
//                                              Toggling That...
                                                chips[index][chipIndex].isExceeded = true
//                                                Getting Last item...
                                                let lastItem = chips[index][chipIndex]
//                                                removing item From Current Row..
//                                                inseting it as new item...
                                                chips.append([lastItem])
                                                chips[index].remove(at:  chipIndex)
                                            }
                                        }
                                        
                                        return Color.clear
                                    },
                                    alignment: .trailing
                                )
                                .clipShape(Capsule())
                                .onTapGesture {
//                                    Removing Data...
                                    chips[index].remove(at: chipIndex)
//                                    If the Inside Array is empty removing that also...
                                    if chips[index].isEmpty{
                                        chips.remove(at: index)
                                    }
                                }
                        }
                    }
                }
            }
                .padding()
            
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3)
//            border...
            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.4),lineWidth: 1.5))
            
//             Text Editor...
            
            TextEditor(text: $text)
                .padding()
//            Border With fixed Size...
                .frame(height: 150)
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.4),lineWidth: 1.5))
            
//             Add button...
            Button {
//                Adding Empty Array id there is Nothing...
                if chips.isEmpty{
                    chips.append([])
                }
                withAnimation {
//                Adding Chips To Last Array...
                chips[chips.count - 1].append(ChipsDataCustomTagView(chipText: text))
//                Clearing Old Text In Editor...
                text = ""
                }
            } label: {
                Text("Add Tag")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(4)
            }
//            Disabling Button When Text is Empty...
            .disabled(text == "")
            .opacity(text == "" ? 0.45 : 1)

        }
        .padding()
    }
}

// Chip Data Model...

struct ChipsDataCustomTagView: Identifiable {
    var id = UUID().uuidString
    var chipText: String
//    To Stop Auto Update...
    var isExceeded = false
}
