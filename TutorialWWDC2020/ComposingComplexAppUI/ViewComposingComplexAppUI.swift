//
//  ViewComposingComplexAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 11/12/21.
//

import SwiftUI

struct ViewComposingComplexAppUI: View {
    var body: some View {
        HomeViewComposingComplexAppUI()
    }
}

struct ViewComposingComplexAppUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewComposingComplexAppUI()
    }
}

struct HomeViewComposingComplexAppUI:View {
    
    @State var selected = serversComposingComplexAppUI.first!
    
    @State var isSmall = UIScreen.main.bounds.height < 750
    
//    Server Tooglle Staus...
    @State var isServerOn = false
    
    var body: some View{
        VStack{
            
            HStack{
                
                Button {
                    
                } label: {
                    Image(systemName: "circle.grid.cross")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.5),lineWidth: 0.5))
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack{
                        Image(systemName: "crow.fill")
                            .foregroundColor(.yellow)
                        
                        Text("Go Premium")
                            .fontWeight(.heavy)
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.vertical,10)
                    .background(Color.black.opacity(0.2))
                    .clipShape(Capsule())
                }

            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15){
                    ForEach(serversComposingComplexAppUI){ server in
                        Image(server.flag)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                            .onTapGesture {
                                withAnimation {
                                    selected = server
                                }
                            }
                            .padding(5)
                            .background(Circle().stroke(Color.white.opacity(selected.id == server.id ? 1 : 0), lineWidth: 1))
                    }
                }
                .padding()
            }
            
            ZStack{
                
//                World Map...
                Image("world")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width - 40)
                
                VStack(spacing: 10){
                    
                    if isServerOn{
                        
                        Text(selected.name)
                            .fontWeight(.semibold)
                    }
                    
                    
                    Text(isServerOn ? "Connecte" : "Not Connected")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    if isServerOn{
                    HStack{
                        Image(selected.flag)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                        
                        Text("222.444.55.67")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    }
                    
                }
                .offset(y: -20)
            }
            .padding(.vertical,isSmall ? 0 : 25)
            
//            toggle Button...
            ZStack(alignment: Alignment(horizontal: .center, vertical: isServerOn ? .bottom : .top)) {
                
                Capsule()
                    .fill(isServerOn ? Color.green.opacity(0.99) : Color.black.opacity(0.9))
                
                VStack{
                    if !isServerOn {
                        Spacer()
                    }
                    
                    Image(systemName: "chevron.\(isServerOn ? "up" :"down")")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    
                    Image(systemName: "chevron.\(isServerOn ? "up" :"down")")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    if isServerOn {
                        Spacer()
                    }
                }
                .offset(y: isServerOn ? 30 :  -30)
                
                ZStack {
                    Capsule()
                        .fill(isServerOn ? Color.green :Color.gray)
                        .frame(height: 180)
                        .padding(10)
                    
                    VStack(spacing: 16){
                        
                        Capsule()
                            .fill(isServerOn ? Color.black.opacity(0.45) : Color.green)
                            .frame(width: 30, height: 8)
                        
                        Text(isServerOn ? "STOP" : "START")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        Image(systemName: "power")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.25))
                            .clipShape(Circle())
                    }
                }
                .onTapGesture {
                    withAnimation {
                        isServerOn.toggle()
                    }
                }
                
            }
            .padding(.bottom,isSmall ? 5 : 15)
            .frame(width: 130)
            .background(
                ZStack{
                    RingsComposingComplexAppUI(width: UIScreen.main.bounds.width / 2, isServerOn: $isServerOn)
                        .offset(y: 70)
                    
                    RingsComposingComplexAppUI(width: UIScreen.main.bounds.width / 1.6, isServerOn: $isServerOn)
                        .offset(y: 80)
                    
                    RingsComposingComplexAppUI(width: UIScreen.main.bounds.width / 1.3 , isServerOn: $isServerOn)
                        .offset(y: 90)
                    
                    RingsComposingComplexAppUI(width: UIScreen.main.bounds.width / 1.1, isServerOn: $isServerOn)
                        .offset(y: 100)
                    
                    RingsComposingComplexAppUI(width: UIScreen.main.bounds.width , isServerOn: $isServerOn)
                        .offset(y: 100)
                }
            )
            .padding(.bottom,isSmall ? 10 : 60)
        }
        .background(
            LinearGradient(gradient: .init(colors: [ isServerOn ?Color.green.opacity(0.5) : Color.black.opacity(0.9),
                                                    Color.gray.opacity(0.8),
                                                    Color.gray.opacity(0.9),
                                                     isServerOn ?Color.green.opacity(0.5) :  Color.black.opacity(0.9)]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all,edges: .all)
                .animation(.easeIn)
        )
        .preferredColorScheme(.dark)
    }
}

func getSize(index: Int) -> CGFloat {
//    different Size Based On index...
    
    if index < 10 || index > 50{
        return 3
    }
    if index > 10 && index < 20{
        return 4
    }
    if index >= 40 && index <= 50{
        return 4
    }else{
        return 5
    }
}

//Rings...

struct RingsComposingComplexAppUI: View{
    
    var width: CGFloat
    @Binding var isServerOn: Bool
    
    var body: some View{
        
        ZStack {
            ForEach(1...60,id:\.self){index in
                Circle()
                    .fill(isServerOn ? Color.green : Color.white)
                    .frame(width: getSize(index: index), height: getSize(index: index))
                    .offset(x: -width / 2)
                    .rotationEffect(.init(degrees: Double(index) * 6))
                    .opacity(getSize(index: index) == 3 ? 0.7  : (isServerOn ? 1 : 0.8))
            }
                
        }
        .frame(width: width)
        .rotationEffect(.init(degrees: 90))
    }
}

// Server Model And Model Data...

struct ServerComposingComplexAppUI: Identifiable {
    var id = UUID().uuidString
    var name: String
    var flag: String
}

var serversComposingComplexAppUI = [
    ServerComposingComplexAppUI(name: "USA", flag: "us"),
    ServerComposingComplexAppUI(name: "India", flag: "in"),
    ServerComposingComplexAppUI(name: "United Kindom", flag: "uk"),
    ServerComposingComplexAppUI(name: "France", flag: "fr"),
    ServerComposingComplexAppUI(name: "Germany", flag: "ge"),
    ServerComposingComplexAppUI(name: "Singapore", flag: "si")
]
