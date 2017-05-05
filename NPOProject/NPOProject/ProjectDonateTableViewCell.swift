//
//  ProjectDonateTableViewCell.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/5.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class ProjectDonateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var donateMoneyButton: UIButton!

    @IBOutlet weak var projectDonate: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        donateMoneyButton.layer.cornerRadius = 5
        donateMoneyButton.clipsToBounds = true
        projectDonate.layer.cornerRadius = 5
        projectDonate.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
