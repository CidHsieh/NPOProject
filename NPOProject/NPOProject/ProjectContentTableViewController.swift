//
//  ProjectContentTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/6.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class ProjectContentTableViewController: UITableViewController {
    
    @IBOutlet weak var donateButtonOutlet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //兩個都要設才能自動調整高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        donateButtonOutlet.layer.cornerRadius = 5
        donateButtonOutlet.clipsToBounds = true
        
        navigationController?.hidesBarsOnSwipe = true
    }
}
