//
//  ProjectDonateTableViewCell.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/5.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class ProjectDonateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var projectDonate: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        projectDonate.layer.cornerRadius = 5
        projectDonate.clipsToBounds = true
        projectDonate.layer.borderWidth = 1.0
        projectDonate.layer.borderColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
