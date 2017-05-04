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
    
    var tempTitle = ""
    var tempText = ""
    var index = ""
    var likeCount = 0
    let shareButt = FBSDKShareButton()
    
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = tempText
        imageView.image = UIImage(named: "\(index)")
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        
        navigationItem.title = tempTitle
        
        //移除tableview分隔線
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        self.tableView.estimatedRowHeight = 50
        
        share()

    }
    func share() {
        //分享按鈕
        shareButt.frame = CGRect(x: UIScreen.main.bounds.width / 2 , y: UIScreen.main.bounds.height / 2, width: 70, height: 40)
        view.addSubview(shareButt)
        shareButt.setTitle("", for: .normal)
        shareButt.setImage(UIImage(named: "Share_000000_25"), for: .normal)
        shareButt.backgroundColor = UIColor.clear
        
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
        } else {
            sender.setImage(UIImage(named: "unlike-1"), for: .normal)
            likeCount -= 1
            likeCountLabel.text = "\(likeCount)"
        }
    }
    
    @IBAction func fbShareButton(_ sender: UIButton) {
        let testButt = FBSDKShareButton()
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "http://npost.tw/archives/23778")
        testButt.shareContent = content
        print("XXXXX")
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 400
        } else {
            return UITableViewAutomaticDimension            
        }
    }
    
}
