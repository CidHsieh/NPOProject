//
//  StoryTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class StoryTableViewController: UITableViewController {
    let stor = Story()
    let lessonsArray = ["輪椅販賣者，楊姐姐",
                        "賣八寶粥的王太太",
                        "賣桑椹的82歲老奶奶",
                        "陽光商圈撿回收的75歲阿嬤",
                        "賣大誌雜誌的伯伯",
    ]
    let photoArray = ["0","1","2","3","4"]
    
    var video:[TKSotryVideo] = [
        TKSotryVideo(title: "台客劇場》我在愛心尾牙認識的阿伯", code: "Bg0AxtZ334c"),TKSotryVideo(title: "台客劇場》給外籍看護的母親節禮物", code: "3DO343LGnE4"),TKSotryVideo(title: "台客劇場》婚姻的黑箱秘密 Secrets and Amnesia", code: "EB10c6qNev4")
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        navigationItem.title = "眉角故事"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //兩個都要設才能自動調整高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return lessonsArray.count
        } else {
            return video.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! StoryOneTableViewCell
            cell1.storyImageView.image = UIImage(named: "\(indexPath.row)")
            cell1.storyTitle.text = lessonsArray[indexPath.row]
            return cell1
        } else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! StoryTwoTableViewCell
            cell2.webView.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(video[indexPath.row].code)")!))
            cell2.videoTitle.text = video[indexPath.row].title
            return cell2
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let pushViewController = storyboard.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
            pushViewController.tempTitle = "\(lessonsArray[indexPath.row])"
            
            pushViewController.index = "\(indexPath.row)"
            
            pushViewController.tempText = stor.story[indexPath.row]
            self.navigationController?.pushViewController(pushViewController, animated: true)
        }
    }
   
}
