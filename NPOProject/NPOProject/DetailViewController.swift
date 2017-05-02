//
//  DetailViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/4/26.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageArray = [String]()
    
    @IBOutlet weak var colleciotnView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailCollectionViewCell
        cell.myImageView.image = UIImage(named: imageArray[indexPath.item])
        return cell
    }
}
