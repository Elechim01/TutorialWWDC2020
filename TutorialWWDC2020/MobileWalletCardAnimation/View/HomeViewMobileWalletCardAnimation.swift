//
//  HomeMobileWalletCardAnimation.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 24/12/21.
//

import SwiftUI

struct HomeViewMobileWalletCardAnimation: View {
    
//    Animation Properties..
    @State var startAnimation = false
    @State var startCatdrotation = false
    @State var selectedCard: CardMobileWalletCardAnimation = CardMobileWalletCardAnimation(cardHolder: "", cardNumber: "", cardValidity: "", cardImage: "")
    
//    Hero Effect...
    @State var cardAnimation = false
    @Namespace var animation
    
//    Color Scheme..
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ScrollView{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "line.horizontal.3.descrease")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                    
                    Text("Welcome Back !!")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image("p1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }


                }
                
//                Card View...
                ZStack{
                    
//                    since Zstack will overlay on one another so last card will be first...
                    
//                    to avoid this were reversing the array
                    ForEach(cardsMobileWalletCardAnimation.indices.reversed(),id:\.self){ index in
                        
                        CardViewMobileWalletCardAnimation(card: cardsMobileWalletCardAnimation[index])
//                        displaying first three Cards...
//                        other all will be hidden...
//                        you can use scrollview to explore all cards..
                        
//                        scaling...
                            .scaleEffect(selectedCard.id == cardsMobileWalletCardAnimation[index].id ? 1 : index == 0 ? 1 : 0.9)
                        
//                         Rotation..
//                        resetting rotation when clicked...
                            .rotationEffect(.init(degrees: startAnimation ? 0 : index == 1 ? -15 : (index == 2 ? 15 : 0)))
                        
                        
//                        On Click..
                            .onTapGesture {
                                animateView(card: cardsMobileWalletCardAnimation[index])
                            }
                        
                            .offset(y: startAnimation ? 0 :  index == 1 ? 60 : (index == 2 ? -60 : 0))
//                        since we applied rotation so we need to change y in order to get x Axis..
                        
//                        Hero Effect..
                            .matchedGeometryEffect(id: "CARD_ANIMATION", in: animation)
                        
//                        Rotating card back to 0deg...
                            .rotationEffect(.init(degrees: selectedCard.id == cardsMobileWalletCardAnimation[index].id && startCatdrotation ? -90 : 0))
                        
//                        Moving the selected Card to top..
                            .zIndex(selectedCard.id == cardsMobileWalletCardAnimation[index].id ? 1000 : 0)
                        
//                        Hiding unselected Cards...
                            .opacity(startAnimation ? selectedCard.id == cardAnimation[index].id ? 1 : 0 : 1)
                          
                    }
                }
//                rotating all cards..
                .rotationEffect(.init(degrees: 90))
//                since were rotating so height wil ve width..
//                -30 will be horizontal padding..
                .frame(height: getRectMobileWalletCardAnimation().width - 30)
                .scaleEffect(0.9)
                .padding(.top,20)
                
//                Total Amount Spent...
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text("Total Amount Spent")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Text("$1,451.00")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,20)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.04).ignoresSafeArea())
//        bluring the whole view...
        .blur(radius: cardAnimation ? 100 : 0)
        .overlay(
            ZStack(alignment: .topLeading){
                
//                Detail View...
                if cardAnimation{
                    
//                    Close Button...
                    Button(action: {
                        
//                        closing the view...
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.5)){
                            
                            startCatdrotation = false
                            selectedCard = CardMobileWalletCardAnimation(cardHolder: "", cardNumber: "", cardValidity: "", cardImage: "")
                            cardAnimation = false
                            startAnimation = false
                        }
                        
                    },label:{
                        Image(systemName: "xmark")
                            .font(.system(size: 18,weight: .bold))
                            .foregroundColor(colorScheme != .dark ? .white : .black)
                            .padding()
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    .padding()
                    
//                    Card View...
                    CardViewMobileWalletCardAnimation(card:selectedCart)
                        .matchedGeometryEffect(id: "CARD_ANIMATION", in: animation)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        )
    }
    
    func animateView(card: CardMobileWalletCardAnimation){
        
//        setting current card...
        selectedCard = card
        
//        rotating card and bluring the whole view...
        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)){
//            to avoid multiple clicks so were avoiding using toggle()....
            startAnimation = true
        }
        
//        After 0.2s Rotating Card...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            withAnimation(.spring()){
                    startCatdrotation = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
            
            withAnimation(.spring()){
                cardAnimation = true
            }
        }
    }
}

// extending view to get Screeen Frame..
extension View{
    func getRectMobileWalletCardAnimation() -> CGRect {
        return UIScreen.main.bounds
    }
}

struct HomeViewMobileWalletCardAnimation_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewMobileWalletCardAnimation()
    }
}

struct CardViewMobileWalletCardAnimation:View {
    
    var card: CardMobileWalletCardAnimation
    
    var body: some View{
        
        Image(card.cardImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
                
                VStack(alignment: .leading, spacing: 10){
                    
                    Spacer()
                    
                    Text(card.cardNumber)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(y: 25)
                    
                    Spacer()
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text("CARD HOLDER")
                                .fontWeight(.bold)
                            
                            Text(card.cardHolder)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Spacer(minLength: 10)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text("VALID TILL")
                                .fontWeight(.bold)
                            
                            Text(card.cardValidity)
                                .fontWeight(.bold)
                        }
                        
                    }
                    .foregroundColor(.white)
                }
                .padding()
            )
    }
}
