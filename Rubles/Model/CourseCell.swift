//
//  CourseCell.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    
    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var labelCurrencyName: UILabel!
    @IBOutlet weak var labelCourse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initCell(currency: Rubles) {
        let labelCourseText = currency.valueDouble! / currency.nominalDouble!
        let transition = labelCourseText
        imageFlag.image = currency.imageFlag
        labelCurrencyName.text = currency.name
        labelCourse.text = String(round(transition * 1000) / 1000)
    }
}
