//
//  AboutUsTableViewCell.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var aboutUsImageView: UIImageView!
    
    @IBOutlet weak var aboutUsTitleLabel: UILabel!
    
    @IBOutlet weak var aboutUsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
