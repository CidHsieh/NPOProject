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
    
    let lessonsArray = ["這不只是一個阿嬤",
                        "這不只是一個阿公",
                        "這不只是一個阿公的故事喔",
                        "這不只是一個阿公、阿嬤的故事喔",
                        "這不只是一個阿嬤的物事喔"
                        ]
    let photoArray = ["0","1","2","3","4","5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stickeyLayout = collectionView.collectionViewLayout as! StickyCollectionViewFlowLayout
        stickeyLayout.firstItemTransform = kFirstItemTransform
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        navigationItem.title = "呆丸眉角"
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

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
        let pushViewController = storyboard.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
        pushViewController.index = "\(indexPath.row)"
        let stor = Story()
        pushViewController.tempText = stor.story[indexPath.row]
        self.navigationController?.pushViewController(pushViewController, animated: true)
    }
}




