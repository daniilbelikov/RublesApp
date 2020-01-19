//
//  SettingsController.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var showCourses: UIButton!
    
    // MARK: - General methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObjects()
    }
    
    private func configureObjects() {
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        showCourses.layer.cornerRadius = 10
    }
    
    // MARK: - Actions
    
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func pushShowAction(_ sender: Any) {
        Model.shared.loadXMLFile(date: datePicker.date)
        dismiss(animated: true)
    }
}
