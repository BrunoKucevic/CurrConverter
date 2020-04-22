//
//  CurrencyItem.swift
//  CurrencyConverter
//
//  Created by Bruno Kučević on 21/04/2020.
//  Copyright © 2020 Bruno Kučević. All rights reserved.
//

import Foundation
import RealmSwift

class CurrencyItem: Object{
    @objc dynamic var foreignCurrency : String = ""
    @objc dynamic var value : Double = 0.0
    @objc dynamic var dateAdded : Date?
    
    var dateString : String?{
        if let date = dateAdded {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-yyyy"
            
            return formatter.string(from: date)
        }
        else{
            return nil
        }
        //return ""
    }
}
