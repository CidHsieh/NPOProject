//
//  AboutUsTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class AboutUsTableViewController: UITableViewController {
    let about = About()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        navigationItem.title = "我們在做什麼"
        
        //兩個都要設才能自動調整高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        
        //移除tableView分隔線
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none


    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return about.aboutImage.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AboutUsTableViewCell
        
        cell.aboutUsImageView.image = UIImage(named: "\(about.aboutImage[indexPath.row])")
        cell.aboutUsTitleLabel.text = about.aboutUsTitle[indexPath.row]
        cell.aboutUsLabel.text = about.aboutUsContent[indexPath.row]
        
        return cell
    }
    
    
    

   }
