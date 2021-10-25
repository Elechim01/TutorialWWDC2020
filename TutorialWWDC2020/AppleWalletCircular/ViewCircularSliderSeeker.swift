//
//  ViewCircularSliderSeeker.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/10/21.
//

import SwiftUI

struct ViewCircularSliderSeeker: View {
    @State var size = UIScreen.main.bounds.width - 100
    @State var progress : CGFloat = 0
    @State var angle : Double = 0
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Circle()
                        .stroke(Color("stoke"),style: StrokeStyle(lineWidth: 55, lineCap: .round, lineJoin: .round))
                        .frame(width: size, height: size)
                    
//                    progresss...
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.green,style: StrokeStyle(lineWidth: 55, lineCap: .butt))
                        .frame(width: size, height: size)
                        .rotationEffect(.init(degrees: -90))
//                    Inner Finish Curve...
                    Circle()
                        .fill(Color("stoke"))
                        .frame(width: 55, height: 55)
                        .offset(x: size / 2)
                        .rotationEffect(.init(degrees: -90))
                    
//                    Drag Circle...
                    Circle()
                        .fill(Color.white)
                        .frame(width: 55, height: 55)
                        .offset(x: size / 2)
                        .rotationEffect(.init(degrees: angle))
//                    adding gesture....
                        .gesture(DragGesture().onChanged(onDrag(value:)))
                        .rotationEffect(.init(degrees: -90))
                    
//                    sample $200
                    Text("$"+String(format: "%0.f", progress * 200))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                }
            } .navigationTitle("Wallet")
                .preferredColorScheme(.dark)
        }
       
       
    }
    func onDrag(value: DragGesture.Value) {
//        claculatin radiants....
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
//        since atan2 will give from -180 to 180...
//        drag cricle Size is 55 So Radius = 27.5
//        size = 55 => Radius = 27.5
        let radiant = atan2(vector.dy - 27.5, vector.dx - 27.5)
        
//        converting to angle...
        var angle = radiant * 180 / .pi
        
//        simple technique for 0 to 360...
//        eg = 360 - 176 = 184...
        if angle < 0 {angle = 360 + angle}
        
        withAnimation(Animation.linear(duration: 0.15)){
            
            let progress = angle / 360
            self.progress = progress
            self.angle = Double(angle)
        }
    }
}

struct ViewCircularSliderSeeker_Previews: PreviewProvider {
    static var previews: some View {
        ViewCircularSliderSeeker()
    }
}
