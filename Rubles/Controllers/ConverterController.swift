//
//  ConverterController.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit
import Foundation

class ConverterController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var labelCoursesForDate: UILabel!
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    
    @IBOutlet weak var buttonFrom: UIButton!
    @IBOutlet weak var buttonTo: UIButton!
    
    @IBOutlet weak var textFrom: UITextField!
    @IBOutlet weak var textTo: UITextField!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textFrom.addDoneButton(title: "Готово",
                                    target: self,
                                    selector: #selector(tapDone(sender:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshButton()
        configureAll()
        textFromEditingChange(self)
    }
    
    // MARK: - IB Actions
    @IBAction func textFromEditingChange(_ sender: Any) {
        let amount = Double(textFrom.text!)
        textTo.text = Model.shared.convert(amount: amount)
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
    
    // MARK: - Public Methods
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    // MARK: - Private Methods
    private func refreshButton() {
        buttonFrom.setTitle(Model.shared.fromCurrency.charCode, for: .normal)
        buttonTo.setTitle(Model.shared.toCurrency.charCode, for: .normal)
    }
    
    private func configureAll() {
        labelCoursesForDate.text = "Курсы на \(Model.shared.currentDate)"
        navigationItem.rightBarButtonItem = nil
    }
}

// MARK: - Extension
extension UITextField {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        // Add the Done button above the keyboard (Text Field).
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        toolBar.barTintColor = #colorLiteral(red: 0.1215686275, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        barButton.tintColor = #colorLiteral(red: 0.9607843137, green: 0.6470588235, blue: 0.2509803922, alpha: 1)
        
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
