//
//  Rubles.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import Foundation
import UIKit

class Rubles {
    // Create a data model that defines the characteristics of the currency.
    var numCode: String?
    var charCode: String?
    var nominal: String?
    var nominalDouble: Double?
    var name: String?
    var value: String?
    var valueDouble: Double?
    
    var imageFlag: UIImage? {
        if let charcodeOne = charCode {
            return UIImage(named: charcodeOne + ".png")
        }
        return nil
    }
    
    class func myRuble() -> Rubles {
        // Determine the ruble currency, which is necessary to calculate the exchange rate of other currencies.
        let ruble = Rubles()
        ruble.charCode = "RUR"
        ruble.name = "Российский рубль"
        ruble.nominal = "1"
        ruble.nominalDouble = 1.0
        ruble.value = "1"
        ruble.valueDouble = 1.0
        return ruble
    }
}
