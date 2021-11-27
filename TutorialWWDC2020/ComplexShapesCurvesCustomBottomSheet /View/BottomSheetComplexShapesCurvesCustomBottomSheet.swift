//
//  BottomSheetComplexShapesCurvesCustomBottomSheet.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 25/11/21.
//

import SwiftUI

struct BottomSheetComplexShapesCurvesCustomBottomSheet: View {
    
    @ObservedObject var serverData : ServerViewModelComplexShapesCurvesCustomBottomSheet
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
        VStack{
            Spacer()
            
            VStack(spacing: 12){
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 60, height: 4)
                Text("SELECT SERVER")
                    .foregroundColor(.gray)
                
                ScrollView(.vertical,showsIndicators: false) {
                    VStack(spacing: 0){
                        ForEach(serverData.servers){ server in
                            CardViewComplexShapesCurvesCustomBottomSheet(server: server,subTitle: serverData.currentServer.name == server.name ? "CURRENTLY SELECTED" : "")
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    serverData.currentServer = server
                                    withAnimation {
                                       
                                        serverData.showSheet.toggle()
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.bottom,edges?.bottom)
                }
                .frame(height: UIScreen.main.bounds.height / 3)
            }
            .padding(.top)
            .background(BlurViewComplexShapesCurvesCustomBottomSheet()
                            .clipShape(CustomCornerComplexShapesCurvesCustomBottomSheet(corners: [.topLeft,.topRight])))
            .offset(y: offset)
//            bottom sheet remove swipe gesture...
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
            .offset(y: serverData.showSheet ? 0 : UIScreen.main.bounds.height)
            
        }
        .ignoresSafeArea()
        .background(
            Color.black.opacity(serverData.showSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    serverData.showSheet.toggle()
                }
        )
    }
    
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0{
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            
            withAnimation(Animation.easeIn(duration: 0.2)){
                
//                checking...
                let height = UIScreen.main.bounds.height / 3
                
                if value.translation.height > height / 1.5{
                    serverData.showSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

