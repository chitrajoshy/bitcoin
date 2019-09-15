//
//  ViewController.swift
//  bitcoin
//
//  Created by Chitra Hari on 30/08/19.
//  Copyright © 2019 Chitra Hari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var finalURL : String = ""
   let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"

   let currencyArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HDK","IDR"]
    
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        getBitCcoinData(url: finalURL)
        
    }
    
//    NETWORKING
    func getBitCcoinData (url : String) {
        
        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {
                print("Sucess! Got the bitcoin data")
                let bitcoinJSON : JSON = JSON(response.result.value!)
                
                self.updateBitcoinData(json: bitcoinJSON)
                
            } else {
                
                print("Error: \(String(describing: response.result.error))")
                self.bitcoinPriceLabel.text = "Connection Issues"
            }
        }
    }
// json parsing
    func updateBitcoinData(json : JSON) {
        
        if let bitcoinResult = json["ask"].double {
            bitcoinPriceLabel.text = "\(bitcoinResult)"
        } else {
            bitcoinPriceLabel.text = "Price Unavailable"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

