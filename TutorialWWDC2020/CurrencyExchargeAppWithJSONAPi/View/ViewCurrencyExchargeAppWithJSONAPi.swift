//
//  ViewCurrencyExchargeAppWithJSONAPi.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/11/21.
//

import SwiftUI

struct ViewCurrencyExchargeAppWithJSONAPi: View {
    var body: some View {
        
        NavigationView{
            
            HomeViewCurrencyExchargeAppWithJSONAPi()
                .navigationTitle("Currency Excharge")
                .preferredColorScheme(.dark)
        }
    }
}

struct ViewCurrencyExchargeAppWithJSONAPi_Previews: PreviewProvider {
    static var previews: some View {
        ViewCurrencyExchargeAppWithJSONAPi()
    }
}

struct HomeViewCurrencyExchargeAppWithJSONAPi: View {
    @State var viewModel = FetchDataCurrencyExchargeAppWithJSONAPi()
    var body: some View {
        
        VStack{
            
            if viewModel.conversionData.isEmpty{
                ProgressView()
            }else{
                ScrollView{
                    
        //            Fetch Data......
                    
                    LazyVStack(alignment: .leading, spacing: 15) {
                        ForEach(viewModel.conversionData) { rate in
                            
                            HStack(spacing: 15){
                                
                                Text(getFlag(currency:rate.currencyName))
                                    .font(.system(size: 65))
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(rate.currencyName)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Text("\(rate.currencyValue)")
                                        .fontWeight(.heavy)
                                }

                            }
                            .padding(.horizontal)
                            
                        }
                    }
                    .padding(.top)
                    
                }
            }
            
        }
        .toolbar {
            Menu {
                ForEach(currecnise,id:\.self){ name in
                    
                    Button {
                        viewModel.updateData(base: name)
                    } label: {
                        Text(name)
                    }

                    
                }
            } label: {
                Text("Base = \(viewModel.base)")
                    .fontWeight(.heavy)
            }

        }
    }
    
 
    
//    getting Country Flag By Currency Name...
    func getFlag(currency: String) -> String{
        
        let  base = 127397
        
        var code = currency
        code.removeLast()
        
        var scalar = String.UnicodeScalarView()
        
        for i in code.utf16{
            scalar.append(UnicodeScalar(base + Int(i))!)
        }
        return String(scalar)
    }
}
