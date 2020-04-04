//
//  RequestError.swift
//  CurrencyConverter
//
//  Created by Bruno Kučević on 16/03/2020.
//  Copyright © 2020 Bruno Kučević. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}
