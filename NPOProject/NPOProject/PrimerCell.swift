//
//  PrimerCell.swift
//  StickyCollectionViewTest
//
//  Created by Cid Hsieh on 2017/4/24.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class PrimerCell: UICollectionViewCell {
    
    @IBOutlet weak var lessonLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var Lesson: String? {
        didSet {
            lessonLabel.text = Lesson
        }
    }
    var SubTitle: String? {
        didSet {
            subTitleLabel.text = SubTitle
        }
    }
    
}
