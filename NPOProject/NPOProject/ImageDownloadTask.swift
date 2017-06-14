//
//  ImageDownloadTask.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/6/14.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import Foundation

import UIKit

class ImageDownLoad {
    var loading:UIActivityIndicatorView?
    
    func loadImageWithURL(url:URL, myImageView: UIImageView){ //用這個方法給一個網址，就去下載圖片
        let session = URLSession(configuration: .default) //生出一個 URLSession
        
        //下載之後檔案的名稱
        let hashFileName = "Cache_\(url.hashValue)"
        //找到快取資料夾的位置
        let cachePath = NSHomeDirectory() + "/Library/Caches/"
        let fullFilePathName = cachePath + hashFileName //最後檔案要存的位置
        
        //在下載前，如果已經下載過的話，...
        let cacheImage = UIImage(contentsOfFile: fullFilePathName)
        if cacheImage != nil {
            myImageView.image = cacheImage //把從快取讀到的圖片秀出來
            print("in local")
            return //就不要繼續執行了
        }
        
        //產生一個下載工作
        let task = session.dataTask(with: url, completionHandler: {
            (data,response, error) in
            //下載完之後會執行的 closure
            
            DispatchQueue.main.async {
                self.loading?.stopAnimating()
            }
            
            if error != nil { // 如果有錯誤，就不要再執行
                return
            }
            if let okData = data { // 如果真的有值，真的下載到圖片
                let downloadImage = UIImage(data: okData) //用下載的資料產生圖片
                DispatchQueue.main.async {               //找到主佇列
                    myImageView.image = downloadImage           //更改畫面的圖片
                }
                //把下載的資料存到手機裡面
                do{
                    let url = URL(fileURLWithPath: fullFilePathName)
                    try okData.write(to: url)
                    print("write to file ok")
                }catch{
                    print(error.localizedDescription)
                    print("write to file failed")
                }
            }
        })
        
        loading?.startAnimating()
        //開始下載
        task.resume()
    }
    
}
