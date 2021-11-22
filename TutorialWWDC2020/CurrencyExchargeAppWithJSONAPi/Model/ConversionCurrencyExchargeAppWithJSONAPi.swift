//
//  ConversionCurrencyExchargeAppWithJSONAPi.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/11/21.
//

import SwiftUI


//For fetching Data...
struct ConversionCurrencyExchargeAppWithJSONAPi: Decodable {
    
    var rates: [String : Double]
    var date: String
    var base: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//For displayinf Data...
struct CurrencyExchargeAppWithJSONAPi : Identifiable {
    
    var id = UUID().uuidString
    var currencyName: String
    var currencyValue: Double
}

var currecnise = ["USD","AUD","EUR","INR","JPY"]
