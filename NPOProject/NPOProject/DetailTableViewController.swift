//
//  DetailTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import FBSDKShareKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var messageCountLabel: UILabel!
    @IBOutlet weak var lookMessageButtonOutlet: UIButton!
    @IBOutlet weak var likeButtonOutlet: UIButton!
    
    @IBOutlet weak var projectButtonOutlet: UIButton!
    var tempTitle = ""
    var tempText = ""
    var index = ""
    var likeCount = 0
    let shareButt = FBSDKShareButton()
    var messageCount = 0
    var like = Bool()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = tempText
        imageView.image = UIImage(named: "\(index)")
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        
        navigationItem.title = tempTitle
        
        //移除tableview分隔線
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.estimatedRowHeight = 50
        
        projectButtonOutlet.layer.cornerRadius = 5
        projectButtonOutlet.clipsToBounds = true
        
        like = UserDefaults.standard.bool(forKey: "like")
        if like {
            likeButtonOutlet.setImage(UIImage(named: "like-1"), for: .normal)
        }
        
        likeCount = UserDefaults.standard.integer(forKey: "likeCount")
        likeCountLabel.text = "\(likeCount)"
        
        share()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let messageArray = UserDefaults.standard.stringArray(forKey: "message") {
            messageCount = messageArray.count
            messageCountLabel.text = "\(messageCount)"
        }
        navigationController?.hidesBarsOnSwipe = true
        
    }
    func share() {
        //分享按鈕
        let shareButt = FBSDKShareButton()
        shareButt.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 30, y: UIScreen.main.bounds.height / 2 + 80, width: 60, height: 30)

        view.addSubview(shareButt)
        shareButt.setTitle("分享", for: .normal)
        
        //設定分享連結
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "http://npost.tw/archives/23778")
        shareButt.shareContent = content
    }
    
    
    @IBAction func messageButtonDidPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let presentController = storyboard.instantiateViewController(withIdentifier: "MessageViewController")
        self.present(presentController, animated: true, completion: nil)
    }
    
    @IBAction func likeButtonDidPressed(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "unlike-1") {
            sender.setImage(UIImage(named: "like-1"), for: .normal)
            likeCount += 1
            likeCountLabel.text = "\(likeCount)"
            like = true
        } else {
            sender.setImage(UIImage(named: "unlike-1"), for: .normal)
            likeCount -= 1
            likeCountLabel.text = "\(likeCount)"
            like = false
        }
        UserDefaults.standard.set(likeCount, forKey: "likeCount")
        UserDefaults.standard.set(like, forKey: "like")
        UserDefaults.standard.synchronize()
    }
    
    
    @IBAction func projectDonateButton(_ sender: UIButton) {
        let tabController = self.tabBarController
        tabController?.selectedIndex = 1
        let navController = tabController?.selectedViewController as? UINavigationController
        navController?.popToRootViewController(animated: true)
    }
    
    @IBAction func fbShareButton(_ sender: UIButton) {
        
    }
    
    @IBAction func lookForDetailMessageButton(_ sender: UIButton) {
        lookMessageButtonOutlet.titleLabel?.text = "查看全部\(messageCount)則回覆"
        tableView.reloadData()
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let presentController = storyboard.instantiateViewController(withIdentifier: "MessageViewController")
        self.present(presentController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 400
        } else {
            return UITableViewAutomaticDimension            
        }
    }
    
}
