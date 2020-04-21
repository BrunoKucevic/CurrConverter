//
//  AlertController.swift
//  CurrencyConverter
//
//  Created by Bruno Kučević on 21/03/2020.
//  Copyright © 2020 Bruno Kučević. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showAlertControllerCustom(title : String, message: String, callback: @escaping () -> Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            callback()
        })
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertAction.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(alertAction)
        alertController.addAction(alertActionCancel)
        self.present(alertController, animated: true, completion: nil)
    }
}
