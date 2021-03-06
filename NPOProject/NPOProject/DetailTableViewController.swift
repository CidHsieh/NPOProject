//
//  DetailTableViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import FBSDKShareKit
import Firebase
import MapKit

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
    var url = ""
    var index = 0
    var likeCount = 0
    let shareButt = FBSDKShareButton()
    var messageCount = 0
    var like = Bool()
    var lat = 0.0
    var lon = 0.0
    var placeTitle = ""
    
    var allStory:Array = [Dictionary<String,Any>]()
    var story = Dictionary<String,Any>()
    var messageArray = [[String]]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //把下載網址變成 URL，用 URL 去呼叫 loadImageWithURL 的方法
        if let imageURL = URL(string: url) {
            let download = ImageDownLoad()
            download.loadImageWithURL(url: imageURL, myImageView: imageView)
        }
        
        descriptionLabel.text = tempText
//        imageView.image = UIImage(named: "\(index)")
        
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
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let ref = Database.database().reference()
        ref.child("newStory").observeSingleEvent(of: .value, with: { (snapshot) in
            if let newStory = snapshot.value as? [Dictionary<String,Any>] {
                self.allStory = newStory
                //                print(self.allStory[self.index])
                self.story = self.allStory[self.index]
                print(self.story)
                if let tempMessageArray = self.story["message"] as? [[String]] {
                    self.messageArray = tempMessageArray
                    print(self.messageArray)
                    self.messageCount = self.messageArray.count
                    self.messageCountLabel.text = "\(self.messageCount)"
                    self.lookMessageButtonOutlet.setTitle("查看全部\(self.messageCount)則回覆", for: .normal)
                    self.lookMessageButtonOutlet.titleLabel?.text = "查看全部\(self.messageCount)則回覆"
                }
            }
        })
    
        navigationController?.hidesBarsOnSwipe = true
//        share()
    }
    
//    func share() {
//        //分享按鈕
//        let shareButt = FBSDKShareButton()
//        
//
//        shareButt.frame = CGRect(x: messageCountLabel.frame.maxX + 40, y: 0, width: 60, height: 30)
//        shareButt.center.y = messageCountLabel.center.y
//
//        tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.contentView.addSubview(shareButt)
//        shareButt.setTitle("分享", for: .normal)
//        
//        //設定分享連結
//        let content = FBSDKShareLinkContent()
//        content.contentURL = URL(string: "http://getlukcy.com/stories/2")
//    }
    
    @IBAction func shareButtonDidPressed(_ sender: UIButton) {
            
        let defaultText = self.tempText

        if let imageToShare = imageView.image {
            let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }        
    }
    
    
    
    @IBAction func messageButtonDidPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let presentController = storyboard.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
        presentController.index = index
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
    
    //按下跳轉至專案頁面
    @IBAction func projectDonateButton(_ sender: UIButton) {
        let tabController = self.tabBarController
        tabController?.selectedIndex = 1
        let navigation = tabController?.viewControllers?[1] as! UINavigationController
        let storyboard = UIStoryboard.init(name: "Donate", bundle: nil)
        let projectController = storyboard.instantiateViewController(withIdentifier: "ProjectTableViewController")
        navigation.pushViewController(projectController, animated: false)
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
    
    @IBAction func navigation(_ sender: UIButton) {
        navigation(lat: lat, lon: lon, placeName: placeTitle)
    }
    func navigation(lat:Double, lon:Double, placeName:String){
        let latitude: CLLocationDegrees = CLLocationDegrees(lat)
        let longitude:CLLocationDegrees = CLLocationDegrees(lon)
        
        let regineDistance:CLLocationDistance = 1000.0
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let reginSpan = MKCoordinateRegionMakeWithDistance(coordinates, regineDistance, regineDistance)
        
        let option = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: reginSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: reginSpan.span)]
        let placeMark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: option)
    }
}
