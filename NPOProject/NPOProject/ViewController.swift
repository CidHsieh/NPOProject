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
    
    let kDemoCell = "primerCell"
    let kCellSizeCoef: CGFloat = 0.7
    let kFirstItemTransform: CGFloat = 0.09
    
    let lessonsArray = ["Create a Hight Quality, High Ranking Search Ad",
                        "Evolve Your Ad Campaigns with Programmatic Buying",
                        "How Remarketing Keeps Customers Coming Back",
                        "Surviving and Thriving on Social Media",
                        "Keep Mobile Users Engaged In and Out of Your App"
                        ]
    let photoArray = ["0","1","2","3","4","5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stickeyLayout = collectionView.collectionViewLayout as! StickyCollectionViewFlowLayout
        stickeyLayout.firstItemTransform = kFirstItemTransform
        navigationController?.navigationBar.barTintColor = UIColor.yellow
        navigationItem.title = "故事牆"

    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessonsArray.count
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
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let pushViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        self.navigationController?.pushViewController(pushViewController, animated: true)
    }
}




