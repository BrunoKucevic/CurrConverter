//
//  RealmService.swift
//  CurrencyConverter
//
//  Created by Bruno Kučević on 21/04/2020.
//  Copyright © 2020 Bruno Kučević. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService{
    
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func save<T : Object>(_ object : T){
        do{
            try! realm.write{
                realm.add(object)
            }
        }catch{
            print(error)
        }
    }
    
    func delete<T: Object>(_ object : T){
        do{
            try! realm.write{
                realm.delete(object)
            }
        }catch{
            print(error)
        }
    }
    
    //MARK: - just practicing. Totally unneccessary for this stage of learning
    func postError(_ error : Error){
        NotificationCenter.default.post(name: NSNotification.Name("Realm error"), object: error)
    }
    
    func observeForRealmErrors(in vc : UIViewController, completion: @escaping (Error?) -> Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Realm error"), object: nil, queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingErrorsForRealm(in vc : UIViewController){
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("Realm error"), object: nil)
    }
}
