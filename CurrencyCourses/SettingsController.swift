//
//  SettingsController.swift
//  CurrencyCourses
//
//  Created by Daniil Belikov on 02/07/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushShowCourses(_ sender: Any) {
        Model.shared.loadXMLFile(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
