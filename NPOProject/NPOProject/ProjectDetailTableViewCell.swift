//
//  ProjectDetailTableViewCell.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/5.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class ProjectDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var porjectImage: UIImageView!
    
    @IBOutlet weak var projectTitle: UILabel!
    
    @IBOutlet weak var projectPreview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
