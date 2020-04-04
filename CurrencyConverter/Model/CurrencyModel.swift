//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Bruno Kučević on 16/03/2020.
//  Copyright © 2020 Bruno Kučević. All rights reserved.
//

import Foundation

struct CurrencyModel: Codable {
    let brojTečajnice: String
    let datumPrimjene: String
    let država, šifraValute, valuta: String
    let jedinica: Int
    let kupovniZaDevize, srednjiZaDevize, prodajniZaDevize: String
    
    var srednjiDouble : NSDecimalNumber?{
        let newString = prodajniZaDevize.replacingOccurrences(of: ",", with: ".")
        return NSDecimalNumber(string: newString)
    }
    
    enum CodingKeys: String, CodingKey {
        case brojTečajnice = "Broj tečajnice"
        case datumPrimjene = "Datum primjene"
        case država = "Država"
        case šifraValute = "Šifra valute"
        case valuta = "Valuta"
        case jedinica = "Jedinica"
        case kupovniZaDevize = "Kupovni za devize"
        case srednjiZaDevize = "Srednji za devize"
        case prodajniZaDevize = "Prodajni za devize"
    }
    
}
