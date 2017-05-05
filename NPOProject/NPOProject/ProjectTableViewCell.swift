//
//  ProjectTableViewCell.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/5.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var peopleLogo: UIImageView!
    
    @IBOutlet weak var progressImage: UIImageView!
    
    @IBOutlet weak var reviewTitle: UILabel!
    
    @IBOutlet weak var reviewContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
