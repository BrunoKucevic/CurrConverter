//
//  CurrencyDataManager.swift
//  CurrencyConverter
//
//  Created by Bruno Kučević on 16/03/2020.
//  Copyright © 2020 Bruno Kučević. All rights reserved.
//

import Foundation

class CurrencyDataManager {
    
    let baseUrl = "https://api.hnb.hr/tecajn/v1"
    let baseUrlForCurrency = "https://api.hnb.hr/tecajn/v1?valuta="
    var currencyModel = [CurrencyModel]()
    var currArray = [String]()
    
    func getCurrencies(callBack : @escaping ([String]) -> Void) {
        JSONDecodeHandler().fetch(for: self.baseUrl) { (result: Result<[CurrencyModel], RequestError>) in
            switch result{
            case .success(let currencies):
                
                currencies.forEach { (curr) in
                    self.currArray.append(curr.valuta)
                }
                callBack(self.currArray)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getValueInHrk(for currency: String?, callback: @escaping ([CurrencyModel]) -> Void){
        //currArray = []
        currencyModel = []
        if let curr = currency{
            let url = "\(baseUrlForCurrency)\(curr)"
            JSONDecodeHandler().fetch(for: url) { (result: Result<[CurrencyModel], RequestError>) in
                switch result{
                case .success(let currs):
                    currs.forEach { (currencyModel) in
                        self.currencyModel.append(currencyModel)
                    }
                    callback(self.currencyModel)
                case .failure(let error):
                    print(error)
                }
            }
        }
        else{
            
            return
        }
    }
}
