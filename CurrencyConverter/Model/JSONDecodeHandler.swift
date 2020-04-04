//
//  JSONDecoder.swift
//  CurrencyConverter
//
//  Created by Bruno Kučević on 16/03/2020.
//  Copyright © 2020 Bruno Kučević. All rights reserved.
//

import Foundation

struct JSONDecodeHandler {

    func fetch<T: Codable>(for urlString: String, completion: @escaping (Result<[T], RequestError>) -> Void){
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            guard error == nil else {
                /*TODO: implement custom alert for error*/
                completion(.failure(.clientError))
                return
            }
            
            guard let response = urlResponse as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.serverError))
                return
            }
            
            guard let jsonData = data else {return}
            
            do{
                let currencyData = try JSONDecoder().decode([T].self, from: jsonData)
                completion(.success(currencyData))
            }catch{
                completion(.failure(.serverError))
            }
        }.resume()
    }
}
