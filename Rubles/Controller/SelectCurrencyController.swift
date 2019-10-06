//
//  SelectCurrencyController.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 GolDuck development. All rights reserved.
//

import UIKit

enum FlagCurrencySelected {
    case from
    case to
}

class SelectCurrencyController: UITableViewController {
    
    var flagCurrency: FlagCurrencySelected = .from

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentCurrency: Rubles = Model.shared.currencies[indexPath.row]
        cell.textLabel?.text = currentCurrency.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency: Rubles = Model.shared.currencies[indexPath.row]
        
        if flagCurrency == .from {
            Model.shared.fromCurrency = selectedCurrency
        }
        
        if flagCurrency == .to {
            Model.shared.toCurrency = selectedCurrency
        }
        dismiss(animated: true)
    }
}