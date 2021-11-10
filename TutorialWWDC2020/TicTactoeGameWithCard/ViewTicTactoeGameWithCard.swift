//
//  ViewTicTactoeGameWithCard.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/11/21.
//

import SwiftUI

struct ViewTicTactoeGameWithCard: View {
    var body: some View {
        NavigationView {
            HomeViewTicTactoeGameWithCard()
                .navigationTitle("Tic Tac Toe")
                .preferredColorScheme(.dark)
        }
    }
}

struct ViewTicTactoeGameWithCard_Previews: PreviewProvider {
    static var previews: some View {
        ViewTicTactoeGameWithCard()
    }
}

struct HomeViewTicTactoeGameWithCard : View{
//    moves ..
    @State var moves : [String] = Array(repeating: "", count: 9)
//    To Identify the current Player...
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    
    var body: some View{
        VStack{
//            GridView For Playing...
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15), count: 3), spacing: 15) {
                
                ForEach(0..<9 ,id:\.self){ index in
                    ZStack {
//                        flip Animation...
                        Color.blue
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                        
                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .opacity(moves[index] != "" ? 1 : 0)
                       
                    }
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(15)
                    .rotation3DEffect(.init(degrees: moves[index] != "" ? 180 : 0),
                                      axis: (x: 0.0, y: 1.0, z: 0.0),
                                      anchor: .center,
                                      anchorZ: 0.0,
                                      perspective: 1.0)
//                    whenever tapped adding move...
                    .onTapGesture {
                        withAnimation(Animation.easeIn(duration: 0.5)){
                            
                            if moves[index] == ""{
                            moves[index] = isPlaying ? "X" : "0"
//                            updating player...
                            isPlaying.toggle()
                            }
                            
                        }
                    }
                }
            }
            .padding(15)
        }
//        whenever moves updated it will check for winner...
        .onChange(of: moves) { value in
            checkWinner()
        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Winner"), message: Text(msg), dismissButton: .destructive(Text("Play Again"), action: {
//                reseting all data...
                withAnimation(Animation.easeIn(duration: 0.5)){
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }))
        }
    }
//    calulcatng width...
    func getWidth() -> CGFloat {
        
//        Horizontal padding = 30
//        spacing = 30
        let width = UIScreen.main.bounds.width - (30 + 30)
        
        return width / 3
    }
    
//    cheking for winner...
    func checkWinner(){
        if checkMoves(player: "X"){
//            promotion alert View...
            msg = "Player X Won!!!"
            gameOver.toggle()
        }
        else if checkMoves(player: "0"){
            
            msg = "Player 0 Won!!!"
            gameOver.toggle()
        }
        else{
//            cheking No Moves./...
            let status = moves.contains { value in
                return value == ""
            }
            
            if !status{
                msg = "Game Over Tied !!!"
                gameOver.toggle()
            }
        }
    }
    
    func checkMoves(player: String)-> Bool{
//        horizontal Moves...
        for i in stride(from: 0, to: 9, by: 3) {
            if moves[i] == player && moves[i + 1] == player && moves[i + 2] == player{
                return true
            }
        }
//        Vertical Moves...
        for i in 0...2{
            if moves[i] == player && moves[i + 3] == player && moves[i + 6] == player{
                return true
            }
        }
//        Checking Diagonal...
        if moves[0] == player && moves[4] == player && moves[8] == player{
            return true
        }
        
        if moves[2] == player && moves[4] == player && moves[6] == player{
            return true
        }
                
        return false
    }
    
}
