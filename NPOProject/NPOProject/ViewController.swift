//
//  ViewController.swift
//  StickyCollectionViewTest
//
//  Created by Cid Hsieh on 2017/4/24.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let activaty = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2, width: 80, height: 80), type: NVActivityIndicatorType.ballSpinFadeLoader, color: .red)
    
    var allStory:Array = [Dictionary<String,Any>]()
    var storyModel = [Storys]()
    
    
    let kDemoCell = "primerCell"
    let kCellSizeCoef: CGFloat = 0.7
    let kFirstItemTransform: CGFloat = 0.09
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stickeyLayout = collectionView.collectionViewLayout as! StickyCollectionViewFlowLayout
        stickeyLayout.firstItemTransform = kFirstItemTransform
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        navigationItem.title = "故事牆"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        activaty.center = self.view.center
        // 啟動 NVActivityIndicatorView 動畫
        self.view.addSubview(activaty)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rechability = Reachability(hostName: "www.apple.com")
        //測試連網狀態，是 enum，如果沒網路的 rawValue == 0
        if rechability?.currentReachabilityStatus().rawValue == 0 {
            //沒網路時，跳出 Alert Controller
            let alertAction = UIAlertController(title: "Error", message: "please check network connection", preferredStyle: .alert)
            alertAction.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alertAction, animated: true, completion: nil)
            
        } else {
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
                            tempLat = lat
                        }
                        if let lon = tempArray["longitude"] as? Double {
                            tempLon = lon
                        }
                        if let des = tempArray["description"] as? String {
                            tempDes = des
                        }
                        if let title = tempArray["title"] as? String {
                            tempTitle = title
                        }
                        if let user = tempArray["user"] as? String {
                            tempUser = user
                        }
                        if let url = tempArray["url"] as? String {
                            tempUrl = url
                        }
                        let tempStoryModel = Storys(latitude: tempLat, longitude: tempLon, description: tempDes, title: tempTitle, user: tempUser, url: tempUrl)
                        self.storyModel.append(tempStoryModel)
                        print(self.storyModel)
                        
                        self.collectionView.reloadData()
                        self.activaty.stopAnimating()
                    }
                }
            })
            activaty.startAnimating()
        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        storyModel.removeAll()
    }
}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDemoCell, for: indexPath) as! PrimerCell
        
        //把下載網址變成 URL，用 URL 去呼叫 loadImageWithURL 的方法
        if let imageURL = URL(string: storyModel[indexPath.row].url) {
            let download = ImageDownLoad()
            download.loadImageWithURL(url: imageURL, myImageView: cell.imageView)
        }
        let lesson = storyModel[indexPath.row].title
        cell.Lesson = lesson
        let subTitle = storyModel[indexPath.row].description
        cell.SubTitle = subTitle
        return cell
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: collectionView.bounds.height * kCellSizeCoef)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: NSInteger) -> CGFloat {
        return 0
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let pushViewController = storyboard.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
        pushViewController.tempTitle = "\(storyModel[indexPath.row].title)"
        
        pushViewController.url = storyModel[indexPath.row].url
        
        pushViewController.tempText = storyModel[indexPath.row].description
        
        pushViewController.index = indexPath.row
        
        pushViewController.lat = storyModel[indexPath.row].latitude
        
        pushViewController.lon = storyModel[indexPath.row].longitude
        
        pushViewController.placeTitle = storyModel[indexPath.row].title
        
        self.navigationController?.pushViewController(pushViewController, animated: true)
                
    }
    
}




