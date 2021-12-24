//
//  ViewAnimatedLoadingScree.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI
struct ViewAnimatedLoadingScree: View {
    var body: some View {
        HomeViewAnimatedLoadingScree()
    }
}

struct ViewAnimatedLoadingScree_Previews: PreviewProvider {
    static var previews: some View {
        ViewAnimatedLoadingScree()
    }
}

struct HomeViewAnimatedLoadingScree:View {
    
//    Anmation Properties...
    @State var offsets : [CGSize] = Array(repeating: .zero, count: 3)
    
//    static offset for one full complete rotation...
    
//    So after One complete rotation it will again fire animation for that were going to use timer...
    @State var timer = Timer.publish(every: 4, on: .current, in: .common).autoconnect()
    
    @State var deleayTime: Double = 0
    
    var locations: [CGSize] = [
    
//        rotation1
        CGSize(width: 110, height: 0),
        CGSize(width: 0, height: -110),
        CGSize(width: -110, height: 0),
//        rotation 2
        CGSize(width: 110, height: 110),
        CGSize(width: 110, height: -110),
        CGSize(width: -110, height: -110),
//        rotation3
        CGSize(width: 0, height: 110),
        CGSize(width: 110, height: 0),
        CGSize(width: 0, height: -110),
//        final resetting rotaton...
        CGSize(width: 0, height: 0),
        CGSize(width: 0, height: 0),
        CGSize(width: 0, height: 0)
    ]
    
    
    var body: some View{
        ZStack{
            Color.purple
                .ignoresSafeArea()
            
//            Loader View...
            VStack(spacing: 10){
                
                HStack(spacing: 10){
                    
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                        .offset(offsets[0])
                }
//                with spacing 100 + 100 + 10....
                .frame(width: 210, alignment:.leading)
                
                HStack(spacing: 10){
                    
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 100, height: 100)
                        .offset(offsets[1])
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                        .offset(offsets[2])
                }
            }
        }
        .onAppear {
            doAnimation()
        }
        .onReceive(timer) { _ in
//            resetting timer..
            print("reDo Animation")
            deleayTime = 0
            doAnimation()
        }
    }
    
    func doAnimation(){
    
//        doing our animation here..
        
//        since we have three offsets so were going to convert this array to subarrays of max three elements..
//        you can directly decalre as subarrays...
//        im doing like this its your choice...
        
        var tempoffset: [[CGSize]] = []
        
        var currentSet: [CGSize] = []
        
        for value in locations {
            
            currentSet.append(value)
            
            if currentSet.count == 3{
//                appending to main array...
                tempoffset.append(currentSet)
//              clearing..
                currentSet.removeAll()
            }
        }
        
//        cheking if any incomplete array...
        if !currentSet.isEmpty{
            
            tempoffset.append(currentSet)
            currentSet.removeAll()
        }
        
//        Animation...
        
        for offset in tempoffset {
            
            for index in offset.indices {
                
//                eachbox shift will take 0.5 sec to finish...
//                so delay will be 0.3 and its multiplies...
                
                doAnimation(delay: .now() + deleayTime, value: offset[index], index: index)
                deleayTime += 0.3
            }
        }
        
        print(tempoffset)
    }
    
    func doAnimation(delay: DispatchTime,value: CGSize,index: Int){
        DispatchQueue.main.asyncAfter(deadline: delay) {
            withAnimation(Animation.easeInOut(duration: 0.5)){
                self.offsets[index] = value
            }
        }
    }
    
}
