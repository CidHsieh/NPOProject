//
//  DetailTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var tempTitle = ""
    var tempText = ""
    var index = ""
    
    
    @IBAction func giveComment(_ sender: UIButton) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = tempText
        imageView.image = UIImage(named: "\(index)")
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        
        navigationItem.title = tempTitle
        
        //移除tableview分隔線
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        self.tableView.estimatedRowHeight = 50

    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 400
        } else {
            return UITableViewAutomaticDimension            
        }
    }
    
}
