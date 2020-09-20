//
//  ConverterController.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit

class ConverterController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var labelCoursesForDate: UILabel!
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    @IBOutlet weak var buttonFrom: UIButton!
    @IBOutlet weak var buttonTo: UIButton!
    @IBOutlet weak var textFrom: UITextField!
    @IBOutlet weak var textTo: UITextField!
    
    // MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDoneButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshButton()
        configureAll()
        textFromEditingChange(self)
    }
    
    // MARK: - Public Methods
    
    func configureDoneButton() {
        self.textFrom.addDoneButton(title: "Готово",
                                    target: self,
                                    selector: #selector(tapDone(sender:)))
    }
    
    @objc
    func tapDone(sender: Any) {
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
    
    // MARK: - IBActions
    
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
    
}
