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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = 80
        tableView.register(UINib(nibName: "ConverterHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyHistoryReusableCell")
        loadItems()
        // Do any additional setup after loading the view.
        
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
    
}

