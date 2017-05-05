//
//  ViewController.swift
//  StickyCollectionViewTest
//
//  Created by Cid Hsieh on 2017/4/24.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let stor = Story()
    
    let kDemoCell = "primerCell"
    let kCellSizeCoef: CGFloat = 0.7
    let kFirstItemTransform: CGFloat = 0.09
    
    let lessonsArray = ["輪椅販賣者，楊姐姐",
                        "賣八寶粥的王太太",
                        "賣桑椹的82歲老奶奶",
                        "陽光商圈撿回收的75歲阿嬤",
                        "賣大誌雜誌的伯伯",
                        "台客劇場"
                        ]
    let photoArray = ["0","1","2","3","4","5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stickeyLayout = collectionView.collectionViewLayout as! StickyCollectionViewFlowLayout
        stickeyLayout.firstItemTransform = kFirstItemTransform
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        navigationItem.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDemoCell, for: indexPath) as! PrimerCell
        let lesson = lessonsArray[indexPath.row]
        let image = photoArray[indexPath.row]
        cell.Lesson = lesson
        cell.Image = image
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
        
        if indexPath.row == photoArray.count-1 {
            let storyboard = UIStoryboard.init(name: "Video", bundle: nil)
            let pushViewController = storyboard.instantiateViewController(withIdentifier: "VideoTableViewController") as! VideoTableViewController
            self.present(pushViewController, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let pushViewController = storyboard.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
            pushViewController.tempTitle = "\(lessonsArray[indexPath.row])"
            
            pushViewController.index = "\(indexPath.row)"
            
            pushViewController.tempText = stor.story[indexPath.row]
            self.navigationController?.pushViewController(pushViewController, animated: true)
        }
    }
    
}




