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
    @objc dynamic var value : NSDecimalNumber = 0.0
    @objc dynamic var dateAdded : Date?
}
