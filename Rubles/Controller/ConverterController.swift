//
//  ConverterController.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 GolDuck development. All rights reserved.
//

import UIKit

class ConverterController: UIViewController {
    
    @IBOutlet weak var labelCoursesForDate: UILabel!
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    
    @IBOutlet weak var buttonFrom: UIButton!
    @IBOutlet weak var buttonTo: UIButton!
    
    @IBOutlet weak var textFrom: UITextField!
    @IBOutlet weak var textTo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFrom.delegate = self
    }
    
    @IBAction func pushFromAction(_ sender: Any) {
        let newController = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        (newController.viewControllers[0] as! SelectCurrencyController).flagCurrency = .from
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true)
    }
    
    @IBAction func pushToAction(_ sender: Any) {
        let newController = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        (newController.viewControllers[0] as! SelectCurrencyController).flagCurrency = .to
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true)
    }
    
    @IBAction func pushDoneAction(_ sender: Any) {
        textFrom.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
    
    @IBAction func textFromEditingChange(_ sender: Any) {
        let amount = Double(textFrom.text!)
        textTo.text = Model.shared.convert(amount: amount)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshButtons()
        textFromEditingChange(self)
        labelCoursesForDate.text = "Курсы на \(Model.shared.currentDate)"
        navigationItem.rightBarButtonItem = nil
    }
    
    func refreshButtons() {
        buttonFrom.setTitle(Model.shared.fromCurrency.charCode, for: .normal)
        buttonTo.setTitle(Model.shared.toCurrency.charCode, for: .normal)
    }
}

extension ConverterController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationItem.rightBarButtonItem = buttonDone
        return true
    }
}
