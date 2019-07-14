//
//  CoursesCell.swift
//  CurrencyCourses
//
//  Created by Alexander Senin & Daniil Belikov on 12/07/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit

class CoursesCell: UITableViewCell {
    
    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var labelCurrencyName: UILabel!
    @IBOutlet weak var labelCourse: UILabel!
    
    func initCell(currency: Currency) {
        imageFlag.image = currency.imageFlag
        labelCurrencyName.text = currency.Name
        labelCourse.text = currency.Value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
