//
//  MessageTableViewCell.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/4.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var messageLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
