//
//  VideoTableViewCell.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/1.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoWebView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
