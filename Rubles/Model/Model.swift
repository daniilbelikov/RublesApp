//
//  Model.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit

class Model: NSObject {
    
    // MARK: - Properties
    static let shared = Model()
    
    var currencies: [Rubles] = []
    var currentDate: String = ""
    
    var fromCurrency: Rubles = Rubles.myRuble()
    var toCurrency: Rubles = Rubles.myRuble()
    
    var currentCharacters: String = ""
    var currentCurrency: Rubles?
    
    var pathForXML: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
        
        if FileManager.default.fileExists(atPath: path) {
            return path
        }
        return Bundle.main.path(forResource: "data", ofType: "xml")!
    }
    
    var urlForXML: URL {
        return URL(fileURLWithPath: pathForXML)
    }
    
    // MARK: - General methods
    
    func convert(amount: Double?) -> String {
        if amount == nil {
            return ""
        }
        let result = ((fromCurrency.nominalDouble! * fromCurrency.valueDouble!) /
            (toCurrency.valueDouble! / toCurrency.nominalDouble!)) * amount!
        
        return String(round(result * 1000) / 1000)
    }
    
    func loadXMLFile(date: Date?) {
        var stringURL = "http://www.cbr.ru/scripts/XML_daily.asp?date_req="
        
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            stringURL = stringURL + dateFormatter.string(from: date!)
        }
        
        let url = URL(string: stringURL)
        let task = URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            
            var errorGlobal: String?
            
            if error == nil {
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
                
                let urlForSave = URL(fileURLWithPath: path)
                
                do {
                    try data?.write(to: urlForSave)
                    print("File downloaded")
                    self.parseXML()
                    
                } catch {
                    print("Error when save data:\(error.localizedDescription)")
                    errorGlobal = error.localizedDescription
                }
                
            } else {
                print("Error when save loadXMLFile:" + error!.localizedDescription)
                errorGlobal = error?.localizedDescription
            }
            
            if let errorGlobal = errorGlobal {
                NotificationCenter.default.post(name: NSNotification.Name("ErrorWhenXMLloading"), object: self, userInfo: ["ErrorName": errorGlobal])
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startLoadingXML"), object: self)
        task.resume()
    }
    
    func parseXML() {
        currencies = [Rubles.myRuble()]
        
        let parser = XMLParser(contentsOf: urlForXML)
        parser?.delegate = self
        parser?.parse()
        print("Data updated")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self)
        
        for value in currencies {
            if value.charCode == fromCurrency.charCode {
                fromCurrency = value
            }
            if value.charCode == toCurrency.charCode {
                toCurrency = value
            }
        }
    }
}

// MARK: - Extension

extension Model: XMLParserDelegate {
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "ValCurs" {
            if let currentDateString = attributeDict["Date"] {
                currentDate = currentDateString
            }
        }
        
        if elementName == "Valute" {
            currentCurrency = Rubles()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "NumCode" {
            currentCurrency?.numCode = currentCharacters
        }
        
        if elementName == "CharCode" {
            currentCurrency?.charCode = currentCharacters
        }
        
        if elementName == "Nominal" {
            currentCurrency?.nominal = currentCharacters
            currentCurrency?.nominalDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
        }
        
        if elementName == "Name" {
            currentCurrency?.name = currentCharacters
        }
        
        if elementName == "Value" {
            currentCurrency?.value = currentCharacters
            currentCurrency?.valueDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
        }
        
        if elementName == "Valute" {
            currencies.append(currentCurrency!)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentCharacters = string
    }
}
