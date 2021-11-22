//
//  FetchDataCurrencyExchargeAppWithJSONAPi.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/11/21.
//

import SwiftUI

class FetchDataCurrencyExchargeAppWithJSONAPi: ObservableObject {
    
    @Published var conversionData : [CurrencyExchargeAppWithJSONAPi] = []
    @Published var base = "USD"
    
    init(){
        fetch()
    }
    
    func fetch(){
//        bisonga registrarsi nel url
        let url = "https://api.exchangeratesapi.io/latest?base=\(base)"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { data, _, _ in
            guard let JSONData = data else {return}
            
            do {
                let conversion = try JSONDecoder().decode(ConversionCurrencyExchargeAppWithJSONAPi.self, from: JSONData)
        
//                    converting Dictionary To Array of Objects....
                
                DispatchQueue.main.async {
                    
//                    Key will be Currency Name....
//                    Value will be currency Value...
                    
                    self.conversionData = conversion.rates.compactMap({ (key,value)-> CurrencyExchargeAppWithJSONAPi? in
                        return CurrencyExchargeAppWithJSONAPi(currencyName: key, currencyValue: value)
                    })
                }
                
            } catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func updateData(base: String){
        self.base = base
        self.conversionData.removeAll()
        fetch()
    }
}

