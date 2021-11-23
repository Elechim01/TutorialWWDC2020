//
//  ViewCustomPullToRefreshControl.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/11/21.
//

import SwiftUI

struct ViewCustomPullToRefreshControl: View {
    var body: some View {
        HomeViewCustomPullToRefreshControl()
    }
}

struct ViewCustomPullToRefreshControl_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomPullToRefreshControl()
    }
}

struct HomeViewCustomPullToRefreshControl: View {
    
    //    sample Data...
    @State var arrayData = ["Hello Data 1","Hello Data 2","Hello Data 3","Hello Data 4","Hello Data 5"]
    @State var refresh = Refresh(started: false, relased: false)
    
    var body: some View{
        
        VStack(spacing: 0){
            
            HStack{
                Text("Michele")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.purple)
                
                Spacer()
            }
            .padding()
            .background(Color.white.ignoresSafeArea(.all, edges: .top))
            
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                
//                geometry reader for calculating position....
                GeometryReader{ reader -> AnyView in
                    
                    DispatchQueue.main.async {
                        if refresh.startOffset == 0{
                            refresh.startOffset = reader.frame(in: .global).minY
                        }
                        
                        refresh.offset = reader.frame(in: .global).minY
                        
                        if refresh.offset - refresh.startOffset > 80 && !refresh.started{
                            refresh.started = true
                        }
                        
//                        checking if refresh uis started and drag is relased..
                        
                        if refresh.startOffset == refresh.offset && refresh.started && !refresh.relased{
                            
                            withAnimation(Animation.linear){
                                refresh.relased = true
                            }
                            updateData()
                        }
                        
//                        checking if invalid becomes valid...
                        if refresh.startOffset == refresh.offset && refresh.started && refresh.relased && refresh.invalid{
                            refresh.invalid = false
                            updateData()
                        }
                        
                    }
                    
                    return AnyView(Color.black.frame(width: 0, height: 0))
                }
                .frame(width: 0, height: 0)
                
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    
                    //                    Arrow and Indicator...
                    if refresh.started && refresh.relased{
                        ProgressView()
                            .offset(y: -35)
                    }else{
                        Image(systemName: "arrow.down")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.gray)
                            .rotationEffect(.init(degrees: refresh.started ? 180 : 0))
                            .offset(y: -25)
                            .animation(.easeIn)
                    }
                    
                    VStack{
                        ForEach(arrayData,id:\.self){ value in
                            
                            HStack{
                                Text(value)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                    }
                    .background(Color.white)
                    
                }
                .offset(y: refresh.relased ? 40 : -10)
            }
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea())
    }
    
    func updateData(){
        
//        disabling invalid Scroll when already data is loading...
        
        
        print("update Data...")
        
//        Delaying For Smooth Animation...
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.linear){
                
                if refresh.startOffset == refresh.offset{
                    arrayData.append("Updated Date")
                    refresh.relased = false
                    refresh.started = false
                }else{
                    refresh.invalid = true
                }
            }
        }
    }
}

// Refresh Model...
struct Refresh {
    
    var startOffset: CGFloat = 0
    var offset: CGFloat = 0
    var started: Bool
    var relased: Bool
    var invalid: Bool = false
}
