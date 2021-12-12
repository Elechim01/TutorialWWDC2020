//
//  ViewTextShimmerEffect.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 12/12/21.
//

import SwiftUI

struct ViewTextShimmerEffect: View {
    var body: some View {
        HomeViewTextShimmerEffect()
    }
}

struct ViewTextShimmerEffect_Previews: PreviewProvider {
    static var previews: some View {
        ViewTextShimmerEffect()
    }
}

struct HomeViewTextShimmerEffect:View {
    
//    toggle For Multicolors...
    @State var multicolor = false
    
    var body: some View{
        VStack(spacing: 25){
            
            TextShimmerViewTextShimmerEffect(text: "Welcome", multiColors: $multicolor)
            
            TextShimmerViewTextShimmerEffect(text: "Back", multiColors: $multicolor)
            
            TextShimmerViewTextShimmerEffect(text: "Michele", multiColors: $multicolor)
            
            Toggle(isOn: $multicolor) {
                Text("Enable Multi Colors")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

//TextShimmer...
struct TextShimmerViewTextShimmerEffect:View {
    
    var text: String
    @State var animation = false
    @Binding var multiColors: Bool
    
    var body: some View{
        ZStack{
            Text(text)
                .font(.system(size: 75, weight: .bold))
                .foregroundColor(Color.white.opacity(0.25))
            
//            MultiColor Text...
            if #available(iOS 15.0, *) {
                HStack(spacing: 0){
                    ForEach(0..<text.count,id:\.self){ index in
                        Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                            .font(.system(size: 75, weight: .bold))
                            .foregroundColor(multiColors ?  randomColor() : Color.white)
                    }
                }
                //            Masking for Shimmer Effect...
                .mask {
                    Rectangle()
                    //                For Some More Nice Effect Were going to use Gradient...
                        .fill(
                            //                        you can use any Color Here...
                            LinearGradient(gradient: .init(colors: [Color.white.opacity(0.5),Color.white,Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                        )
                        .rotationEffect(.init(degrees: 70))
                        .padding(20)
                    //                Moving View Continously...
                    //                so it will create Shimmer Effect...
                        .offset(x: -250)
                        .offset(x: animation ? 500 : 0)
                }
                .onAppear{
                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)){
                        animation.toggle()
                    }
                }
            } else {
                // Fallback on earlier versions
                Text("NO IOS15")
            }
        }
    }
    
//    Random Color...
    
    func randomColor() -> Color {
        let color = UIColor(red:1, green: CGFloat(CFloat.random(in: 0...1)), blue: CGFloat(CFloat.random(in: 0...1)), alpha: 1)
        return Color(color)
    }
    
}
