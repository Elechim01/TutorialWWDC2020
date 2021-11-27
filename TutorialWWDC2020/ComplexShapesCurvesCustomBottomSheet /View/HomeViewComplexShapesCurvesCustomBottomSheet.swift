//
//  HomeViewComplexShapesCurvesCustomBottomSheet.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 25/11/21.
//

import SwiftUI

struct HomeViewComplexShapesCurvesCustomBottomSheet: View {
    
    var gradient1 = [Color.green,Color.orange,Color.blue]
    
    var gradient = [Color.red,Color.green,Color.orange,Color.blue]
    
    @StateObject var serverData = ServerViewModelComplexShapesCurvesCustomBottomSheet()
    
    var body: some View {
        ZStack{
            VStack{
                
                VStack {
                    Text("AESTER")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    
                    Text("STATUS")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text(serverData.isConnected ? "CONNECTED" : "DISCONNECTED")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top,5)
                        .padding(.bottom,20)
                }
                .frame(height: UIScreen.main.bounds.height / 3.3)
                
                //            Button...
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    
                    LinearGradient(gradient: .init(colors: gradient1), startPoint: .top, endPoint: .bottom)
                        .clipShape(CustomShapeComplexShapesCurvesCustomBottomSheet())
                    
                    VStack {
                        
                        Button {
                            serverData.isConnected.toggle()
                        } label: {
                            VStack(spacing: 15){
                                Image(systemName: "power")
                                    .font(.system(size: 70))
                                    .foregroundColor(serverData.isConnected ? Color.red.opacity(0.6) : Color.purple)
                                
                                Text(serverData.isConnected ? "STOP" : "START")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            .padding(50)
                            .background(
                                LinearGradient(gradient: .init(colors: [Color.gray,Color.white]), startPoint: .top, endPoint: .bottom)
                            )
                            .clipShape(Circle())
                            .padding(15)
                            .background(Color.orange.opacity(0.8))
                            .clipShape(Circle())
                            .padding(15)
                            .background(Color.red.opacity(0.7))
                            .clipShape(Circle())
                        }
                        .offset(y: -65)
                        .padding(.bottom,-65)
                        Spacer()
                        
                        Button {
                            withAnimation {
                                serverData.showSheet.toggle()
                            }
                        } label: {
                            //                    Card View...
                            CardViewComplexShapesCurvesCustomBottomSheet(server: serverData.currentServer, subTitle: "")
                                .background(BlurViewComplexShapesCurvesCustomBottomSheet())
                                .clipShape(Capsule())
                                .padding()
                        }
                        
                        
                        Spacer()
                    }
                }
                .padding(.top,60)
                
                
                
                
                Spacer()
            }
            
            BottomSheetComplexShapesCurvesCustomBottomSheet(serverData: serverData)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            ZStack{
                LinearGradient(gradient: .init(colors: gradient), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                Color.black.opacity(0.1)
                    .ignoresSafeArea(.all,edges: .top)
            }
        )
    }
}

struct HomeViewComplexShapesCurvesCustomBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewComplexShapesCurvesCustomBottomSheet()
    }
}
