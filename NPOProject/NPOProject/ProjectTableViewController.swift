//
//  ProjectTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/5.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class ProjectTableViewController: UITableViewController {
    
    let reviewTitle = "前情提要"
    let reviewContent = "我們從故事牆的回收阿嬤故事發現，在台灣有一群辛苦收集回收物的阿公阿嬤，散落在各個社區角落，因年老無法從事其他技術或消耗體力工作，因此選擇無技術、較無體力需求的撿拾回收工作，換取微薄收入。我們希望能透過一些方法，同時減輕這群人的負擔，希望在未來的日子裡，能輔導他們用這樣的方式，花費較少的時間、體力，達到相同的效果($)，減輕身體疲憊負擔"
    let project = Project()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        navigationItem.title = ""
        
        //兩個都要設才能自動調整高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ProjectTableViewCell
            cell.peopleLogo.image = UIImage(named: "peopleLogo")
            cell.progressImage.image = UIImage(named: "projectProgress")
            cell.reviewTitle.text = reviewTitle
            cell.reviewContent.text = reviewContent
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ProjectDetailTableViewCell
            cell.porjectImage.image = UIImage(named: "project\(indexPath.row)")
            cell.projectTitle.text = project.projectTitle[indexPath.row]
            cell.projectPreview.text = project.projaetPreview[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! ProjectDonateTableViewCell
            return cell
            
        }
        
    }
    
    
    
}
