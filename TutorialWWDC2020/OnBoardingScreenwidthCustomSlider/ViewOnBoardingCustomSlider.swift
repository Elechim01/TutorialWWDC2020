//
//  ViewOnBoardingCustomSlider.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 01/11/21.
// colort,color2

import SwiftUI

struct ViewOnBoardingCustomSlider: View {
    @State var goToHome = false
    var body: some View {
        ZStack{
            if goToHome {
                Text("Home Screen")
            }else{
                OnboardScreen()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("Successf"))) { _ in
            withAnimation {
                self.goToHome = true
            }
        }
    
    }
}

struct ViewOnBoardingCustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        ViewOnBoardingCustomSlider()
    }
}
struct OnboardScreen: View {
    
    @State var maxWidth = UIScreen.main.bounds.width - 100
    @State var offset: CGFloat = 0
    
    var body: some View{
        ZStack{
            Color("Color2")
                .ignoresSafeArea(.all, edges: .all)
            VStack{
                
                Spacer(minLength: 0)
                
                Text("SMART LEARN")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Text("Don't waste your time. Learn mskskskfjlanmklefklwmecfoie")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.bottom)
                
                Image("g1")
                    .resizable()
                    .frame(width: 400, height: 400)
                
                Spacer(minLength: 0)
                
//                Slider...
                ZStack{
                    Capsule()
                        .fill(Color.white.opacity(0.1))
//                    Background Progress...
                    HStack{
                    Capsule()
                        .fill(Color("Colort"))
                        .frame(width: calculateWidth() + 65)
                        
                        Spacer(minLength: 0)
                    }
                    
                    Text("SWIPE TO START")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading,30)
                    
                    HStack{
                        ZStack{
                            Image(systemName: "chevron.right")
                            
                            Image(systemName: "chevron.right")
                                .offset(x: -10)
                        }
                        .foregroundColor(.white)
                        .offset(x: 5)
                        .frame(width: 65, height: 65)
                        .background(Color("Colort"))
                        .clipShape(Circle())
                        .offset(x: offset)
                        .gesture(DragGesture().onChanged(onChange(value:)).onEnded(onEnd(value:)))
                        
                        Spacer()
                    }
                }
                .frame(width: maxWidth, height: 65)
                .padding(.bottom)
            }
        }
    }
    
    func calculateWidth() -> CGFloat {
        let percent = offset / maxWidth
        return percent * maxWidth
    }
    
    func onChange(value: DragGesture.Value){
//        Updating..
        if value.translation.width > 0 && offset <= maxWidth - 65{
            offset = value.translation.width
        }
    }
    func onEnd(value: DragGesture.Value){
        //        back Off Animation..
        withAnimation(.easeInOut(duration: 0.3)){
            if offset > 180{
                offset = maxWidth - 65
                
//                Notify User...
                
//                selaying for animation complete...
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                }
                
            }else{
                offset = 0
            }
        }
    }
}
