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
        alertAction.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//class Alert{
//    func showAlertControllerCustom(title : String, message: String, viewcontroller : UIViewController, callback: @escaping () -> Void){
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//            callback()
//        })
//        alertAction.setValue(UIColor.red, forKey: "titleTextColor")
//        alertController.addAction(alertAction)
//        viewcontroller.present(alertController, animated: true, completion: nil)
//    }
//}
