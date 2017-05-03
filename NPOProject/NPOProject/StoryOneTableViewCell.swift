//
//  StoryOneTableViewCell.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class StoryOneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var storySubTitle: UILabel!

    var likeOrUnlike = Array(repeating: false, count: 5)
    
    @IBAction func likeButtonDidPressed(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "unlike") {
            sender.setImage(UIImage(named: "like"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "unlike"), for: .normal)
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
