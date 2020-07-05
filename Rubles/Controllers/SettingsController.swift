//
//  SettingsController.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var showCourses: UIButton!
    
    // MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if var textAttributes = navigationController?.navigationBar.titleTextAttributes {
            textAttributes[NSAttributedString.Key.foregroundColor] = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }

    // MARK: - Private Methods
    
    private func configureObjects() {
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        showCourses.layer.cornerRadius = 10
    }
    
    // MARK: - IBActions
    
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func pushShowAction(_ sender: Any) {
        Model.shared.loadXMLFile(date: datePicker.date)
        dismiss(animated: true)
    }
    
}
