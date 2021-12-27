//
//  HomeViewLoginPageUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 27/12/21.
//

import SwiftUI

struct HomeViewLoginPageUI: View {

    @State var maxCircleHeight: CGFloat = 0
    
    @State var showSingUp = false
    
    var body: some View {
        
        VStack{
            
//            Top Rings view...
//            Max Height will be width of the Screen...
            
//            Why Geometry Reader?
//            since height will vary for different screens...
//            so in order to get the height we used...
            GeometryReader{ proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                
                DispatchQueue.main.async {
                    
                    if maxCircleHeight == 0{
                        maxCircleHeight = height
                    }
                }
                
                return AnyView(
                    
                    ZStack{
                       
                        Circle()
                            .fill(Color.black)
                            .offset(x: getRectLoginPageUI().width / 2, y: -height / 1.3)
                        
                        Circle()
                            .fill(Color.black)
                            .offset(x: -getRectLoginPageUI().width / 2, y: -height / 1.5)
                        
                        Circle()
                            .fill(Color.blue)
                            .offset(y: -height / 1.3)
                            .rotationEffect(.init(degrees: -5))
                    }
                )
            }
            .frame(maxHeight: getRectLoginPageUI().width)
            
            ZStack{
                if showSingUp{
                    SingUpLoginPageUI()
                        .transition(.move(edge: .trailing))
                }else{
                    LoginLoginPageUI()
                        .transition(.move(edge: .trailing))
                }
            }
//            removing Unwanted Space...
            .padding(.top, -maxCircleHeight / (getRectLoginPageUI().height < 75 ? 1.5 : 1.6))
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay(
            
            HStack{
            
                Text(showSingUp ? "New Member" : "Already Member")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Button {
                    withAnimation {
                        showSingUp.toggle()
                    }
                } label: {
                    Text(showSingUp ? "sing in" : "sign up")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                }
            }
            .padding(.bottom,getSafeAreaLoginPageUI().bottom == 0 ? 15 : 0)
            
            ,alignment: .bottom
        )
        .background(
        
//            Bottom Rings..
            HStack{
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 70, height: 70)
                    .offset(x: -30,y: getRectLoginPageUI().height < 750 ? 10 : 0)
                
                Spacer(minLength: 0)
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 110, height: 110)
                    .offset(x: 40, y: 20)
            }
            .offset(y: getSafeAreaLoginPageUI().bottom + 30)
            ,alignment: .bottom
        )
    }
}

struct HomeViewLoginPageUI_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewLoginPageUI()
    }
}

// ectending view to get screen Size...
extension View{
    
    func getRectLoginPageUI() -> CGRect {
        return UIScreen.main.bounds
    }
    
//    Getting Safe Area...
    func getSafeAreaLoginPageUI() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
