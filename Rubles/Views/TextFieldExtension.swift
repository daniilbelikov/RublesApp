//
//  TextFieldExtension.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        // Add the Done button above the keyboard (Text Field).
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        toolBar.barTintColor = #colorLiteral(red: 0.1215686275, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                       target: nil, action: nil)
        
        let barButton = UIBarButtonItem(title: title, style: .plain,
                                        target: target, action: selector)
        
        barButton.tintColor = #colorLiteral(red: 0.9607843137, green: 0.6470588235, blue: 0.2509803922, alpha: 1)
        
        toolBar.setItems([flexible, barButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
}
