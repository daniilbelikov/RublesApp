//
//  SelectCurrencyController.swift
//  CurrencyCourses
//
//  Created by Daniil Belikov on 14/06/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit

enum FlagCurrencySelected {
    case from
    case to
}

class SelectCurrencyController: UITableViewController {
    
    var flagCurrency: FlagCurrencySelected = .from
    
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentCurrency: Currency = Model.shared.currencies[indexPath.row]
        cell.textLabel?.text = currentCurrency.Name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency: Currency = Model.shared.currencies[indexPath.row]
        if flagCurrency == .from {
            Model.shared.fromCurrency = selectedCurrency
        }
        
        if flagCurrency == .to {
            Model.shared.toCurrency = selectedCurrency
        }
        dismiss(animated: true, completion: nil)
    }
}
