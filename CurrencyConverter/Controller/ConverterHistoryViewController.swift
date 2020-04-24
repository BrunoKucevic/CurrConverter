//
//  ConverterHistoryViewController.swift
//  CurrencyConverter
//
//  Created by Bruno Kučević on 21/04/2020.
//  Copyright © 2020 Bruno Kučević. All rights reserved.
//

import UIKit
import RealmSwift

class ConverterHistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var currencyItemArray : Results<CurrencyItem>?
    var notificationToken : NotificationToken?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ConverterHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyHistoryReusableCell")
        notificationToken = RealmService.shared.realm.observe { (notification, realm) in
            self.tableView.reloadData()
        }
        RealmService.shared.observeForRealmErrors(in: self) { (error) in
            print(error!)
        }
        loadItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        notificationToken?.invalidate()
    }
    
    func loadItems(){
        currencyItemArray = RealmService.shared.realm.objects(CurrencyItem.self)
    }
}

extension ConverterHistoryViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyItemArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyHistoryReusableCell", for: indexPath) as! ConverterHistoryTableViewCell
        cell.currencyInfoLabel.text = currencyItemArray?[indexPath.row].foreignCurrency ?? "No items added"
        cell.currencyInfoDateLabel.text = currencyItemArray?[indexPath.row].dateString ?? "No date added"
        return cell;
    }
    
    
}

extension ConverterHistoryViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (ac, view, success: (Bool) -> Void) in
            guard let item = self.currencyItemArray?[indexPath.row] else {return}
            RealmService.shared.delete(item)
            success(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let sendEmail = UIContextualAction(style: .normal, title: "Send email") { (ac, view, success: (Bool) -> Void) in
            print("Email")
            success(true)
        }
        sendEmail.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [sendEmail])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


