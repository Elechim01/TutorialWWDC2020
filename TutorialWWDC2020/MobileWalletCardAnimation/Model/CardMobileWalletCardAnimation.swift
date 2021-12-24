//
//  CardMobileWalletCardAnimation.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 24/12/21.
//

import SwiftUI

// Card Model And Sample Data...
struct CardMobileWalletCardAnimation: Identifiable {
   
    var id = UUID().uuidString
    var cardHolder: String
    var cardNumber: String
    var cardValidity: String
    var cardImage: String
}
var cardsMobileWalletCardAnimation  = [
    CardMobileWalletCardAnimation(cardHolder: "123456", cardNumber: "2244668800", cardValidity: "21-02-2030", cardImage: "p1"),
    CardMobileWalletCardAnimation(cardHolder: "123456", cardNumber: "2244668800", cardValidity: "21-02-2030", cardImage: "p2"),
    CardMobileWalletCardAnimation(cardHolder: "123456", cardNumber: "2244668800", cardValidity: "21-02-2030", cardImage: "p3"),
    CardMobileWalletCardAnimation(cardHolder: "123456", cardNumber: "2244668800", cardValidity: "21-02-2030", cardImage: "p4"),

]

