////
////  ViewController.swift
////  CurrencyConverter
////
////  Created by Bruno Kučević on 15/03/2020.
////  Copyright © 2020 Bruno Kučević. All rights reserved.
////
//
//import UIKit
//
//class Vc: UIViewController, UIPickerViewDataSource {
//    
//    
//    var currDataManager = CurrencyDataManager()
//    var stringArray : [String] = []
//    var currencyValue : NSDecimalNumber = 0.0
//    var pickedCurrency : String?
//    @IBOutlet weak var currencyPicker: UIPickerView!
//    @IBOutlet weak var valueTextField: UITextField!
//    @IBOutlet weak var converterResultLabel: UILabel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        currencyPicker.delegate = self
//        currencyPicker.dataSource = self
//        valueTextField.delegate = self
//        currDataManager.getCurrencies { (currencies) in
//            DispatchQueue.main.async {
//                self.stringArray = currencies
//                self.currencyPicker.reloadAllComponents()
//            }     
//        }
//    }
//    
//    @IBAction func onConvertButtonPressed(_ sender: UIButton) {
//        currDataManager.getValueInHrkForDate(for: pickedCurrency, for: "2020-04-03") { (currencies) in
//            DispatchQueue.main.async {
//                print(currencies)
//            }
//        }
//        
//        
//        if let currency = pickedCurrency, let value = Decimal(string: valueTextField.text!) {
//            currDataManager.getValueInHrk(for: currency) { (currencies) in
//                DispatchQueue.main.async {
//                    self.currencyPicker.reloadAllComponents()
//                    self.converterResultLabel.text = currencies[0].srednjiZaDevize
//                    guard let srednji = currencies[0].srednjiDouble else {return}
//                    
//                    self.currencyValue = srednji.multiplying(by: NSDecimalNumber(decimal: value))
//                    
//                    self.converterResultLabel.text = String(format: "%@", self.currencyValue)
//                }
//            }
//        }
//        else{
//            /*TODO: error*/
//        }
//        valueTextField.endEditing(true)
//    }
//    
//}
////MARK: - UIPickerViewDelegate
//extension ViewController: UIPickerViewDelegate{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1;
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return stringArray.count//currDataManager.currencyModel.count /*TODO: return the number of currencies
//        //that get returned from the api*/;
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return stringArray[row]
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        pickedCurrency = stringArray[row]
//        currDataManager.getValueInHrk(for: stringArray[row]) { (currencies) in
//            DispatchQueue.main.async {
//                print(self.stringArray[row])
//                self.currencyPicker.reloadAllComponents()
//                self.converterResultLabel.text = currencies[0].srednjiZaDevize
//                self.showAlertControllerCustom(title: "Obavijest", message: "Na datum \(currencies[0].datumPrimjene) vrijednost je \(currencies[0].srednjiZaDevize). Želite li spremiti pretragu?") {
//                    if let srednji = currencies[0].srednjiDouble{
//                        self.currencyValue = srednji
//                    }
//                    
//                }
//            }
//        }
//    }
//}
////MARK: - UITextFieldDelegate
//extension Vc: UITextFieldDelegate{
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        valueTextField.endEditing(true);
//        return true;
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        valueTextField.text = "";
//    }
//    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text != ""{
//            return true;
//        }else{
//            textField.placeholder = "Type something"
//            return false;
//        }
//    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
//        let compSepByCharInSet = string.components(separatedBy: aSet)
//        let numberFiltered = compSepByCharInSet.joined(separator: "")
//        return string == numberFiltered
//    }
//}
//
//
