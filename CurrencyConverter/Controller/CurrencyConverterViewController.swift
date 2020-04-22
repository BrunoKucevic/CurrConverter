//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Bruno Kučević on 21/04/2020.
//  Copyright © 2020 Bruno Kučević. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController, UIPickerViewDataSource {
    
    var currDataManager = CurrencyDataManager()
    var stringArray : [String] = []
    var currencyValue : NSDecimalNumber = 0.0
    var pickedCurrency : String?
    let formatter = DateFormatter()
    var pickerRow : Int = 0;
    
    @IBOutlet weak var converterResultLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        valueTextField.delegate = self
        currDataManager.getCurrencies { (currencies) in
            DispatchQueue.main.async {
                self.stringArray = currencies
                self.currencyPicker.reloadAllComponents()
            }
        }
        formatter.dateFormat = "yyyy-MM-dd"
    }
    
    @IBAction func onConvertButtonPressed(_ sender: UIButton) {
        guard let pickedCurr = pickedCurrency, let value = Decimal(string: self.valueTextField.text!) else {return}
        currDataManager.getValueInHrkForDate(for: pickedCurr, for: formatter.string(from: Date())) { (currencies) in
            DispatchQueue.main.async {
                self.pickerRow = self.currencyPicker.selectedRow(inComponent: 0)
                guard let srednji = currencies[self.pickerRow].srednjiDouble else {return}
                
                self.currencyValue = srednji.multiplying(by: NSDecimalNumber(decimal: value))
                
                self.converterResultLabel.text = String(format: "%@", self.currencyValue)
                self.showAlertControllerCustom(title: "Obavijest", message: "Na datum \(currencies[self.pickerRow].datumPrimjene) srednji tečaj valute \(currencies[self.pickerRow].valuta) je \(self.currencyValue). Želite li spremiti pretragu?") {

                    let item = CurrencyItem()
                    item.foreignCurrency = currencies[self.pickerRow].valuta
                    item.value = Double(srednji)
                    item.dateAdded = Date()
                    RealmService.shared.save(item)
                }
            }
        }
        valueTextField.endEditing(true)
    }
    
}

//MARK: - UIPickerViewDelegate
extension CurrencyConverterViewController: UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stringArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stringArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCurrency = stringArray[row]
        currDataManager.getValueInHrk(for: stringArray[row] ) { (currency) in
            DispatchQueue.main.async {
                self.currencyPicker.reloadAllComponents()
                self.converterResultLabel.text = currency[0].srednjiZaDevize
            }
        }
    }
}
//MARK: - UITextFieldDelegate
extension CurrencyConverterViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        valueTextField.endEditing(true);
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        valueTextField.text = "";
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true;
        }else{
            textField.placeholder = "Type something"
            return false;
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}
