//
//  HomeViewModelAddtoBagAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 20/12/21.
//

import SwiftUI

class HomeViewModelAddtoBagAnimations: ObservableObject {
    
    @Published var showCart = false
    @Published var selectedSize = ""
    
//    Animaton Properties...
    @Published var startAnimation = false
    @Published var showAnimation = false
    
    @Published var showBag = false
    @Published var saveCart = false
    
    @Published var additemtocart = false
    
    @Published var endAnimation = false
    
//    cart items...
    @Published var cartItems = 0
    
    
//    performing Animations...
    func performAnimations(){
        
        withAnimation(.easeInOut(duration: 0.8)){
            showAnimation.toggle()
        }
        
//        chain Animations...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
            withAnimation(.easeInOut){
                self.showBag.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
            withAnimation(.easeInOut(duration: 0.5)){
                self.saveCart.toggle()
            }
        }
        
//        0.75 + 0.5 = 1.25
//        beecause to start animation before the shoe comes to cart...
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1){
           
            self.additemtocart.toggle()
        }
        
//        end animation will start at 1.25..
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25){
           
            withAnimation(.easeInOut(duration: 0.5)){
                self.endAnimation.toggle()
            }
        }
    }
    
    func resetAll(){
//        giving some time to finish animations..
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            withAnimation {
                self.showCart.toggle()
            }
            
            self.startAnimation = false
            self.endAnimation = false
            self.selectedSize = ""
            self.additemtocart = false
            self.showBag = false
            self.showAnimation = false
            self.saveCart = false
            self.cartItems += 1
            
        }
    }
    
}

