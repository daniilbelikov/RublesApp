//
//  SettingsController.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 GolDuck development. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var showCourses: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        showCourses.layer.cornerRadius = 12
    }
    
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func pushShowCourses(_ sender: Any) {
        Model.shared.loadXMLFile(date: datePicker.date)
        dismiss(animated: true)
    }
}
