//
//  StoryTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import FBSDKShareKit
import Firebase

class StoryTableViewController: UITableViewController {
    var allStory:Array = [Dictionary<String,Any>]()
    var storyModel = [Storys]()

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = "故事牆"
        
        //兩個都要設才能自動調整高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        
        //移除tableView分隔線
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        //捲動隱藏NevigationBar
        navigationController?.hidesBarsOnSwipe = true
        
        
        let ref = Database.database().reference()
        ref.child("newStory").observeSingleEvent(of: .value, with: { (snapshot) in
            if let newStory = snapshot.value as? [Dictionary<String,Any>] {
                self.allStory = newStory

                for i in 0...self.allStory.count-1 {
                    var tempLat = 0.0
                    var tempLon = 0.0
                    var tempDes = ""
                    var tempTitle = ""
                    var tempUser = ""
                    var tempUrl = ""
                    let tempArray = self.allStory[i]
                    
                    if let lat = tempArray["latitude"] as? Double {
//                        print(lat)
                        tempLat = lat
                    }
                    if let lon = tempArray["longitude"] as? Double {
//                        print(lon)
                        tempLon = lon
                    }
                    if let des = tempArray["description"] as? String {
//                        print(des)
                        tempDes = des
                    }
                    if let title = tempArray["title"] as? String {
//                        print(title)
                        tempTitle = title
                    }
                    if let user = tempArray["user"] as? String {
//                        print(user)
                        tempUser = user
                    }
                    if let url = tempArray["url"] as? String {
                        tempUrl = url
                    }
                    let tempStoryModel = Storys(latitude: tempLat, longitude: tempLon, description: tempDes, title: tempTitle, user: tempUser, url: tempUrl)
//                    print(tempStoryModel.description)
                    self.storyModel.append(tempStoryModel)
                    print(self.storyModel)
                    self.tableView.reloadData()

                }
            }
        })
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return storyModel.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! StoryOneTableViewCell
            cell1.storyImageView.image = UIImage(named: "\(indexPath.row)")
            cell1.storyTitle.text = storyModel[indexPath.row].title
//            cell1.storySubTitle.text = storyModel[indexPath.row].description
        
            return cell1
        
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let pushViewController = storyboard.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
            pushViewController.tempTitle = "\(storyModel[indexPath.row].title)"
            
//            pushViewController.index = "\(indexPath.row)"
            
            pushViewController.tempText = storyModel[indexPath.row].description
            self.navigationController?.pushViewController(pushViewController, animated: true)
        }
    }
   
}
