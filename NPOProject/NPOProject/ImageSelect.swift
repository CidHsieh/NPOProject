//
//  ImageSelect.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/20.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
class SelectImage {
    func selsetImage(imagePickerController: UIImagePickerController, myController: UIViewController) {
        // 建立一個 UIAlertController 的實體
        // 設定 UIAlertController 的標題與樣式為 動作清單 (actionSheet)
        imagePickerController.allowsEditing = true
        let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的片", preferredStyle: .actionSheet)
        // 建立三個 UIAlertAction 的實體
        // 新增 UIAlertAction 在 UIAlertController actionSheet 的 動作 (action) 與標題
        let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (void) in
            // 判斷是否可以從照片圖庫取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
                imagePickerController.sourceType = .photoLibrary
                myController.present(imagePickerController, animated: true, completion: nil)
            }
        }
        let imageFroemCamera = UIAlertAction(title: "相機", style: .default) { (void) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                myController.present(imagePickerController, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (void) in
            imagePickerAlertController.dismiss(animated: true, completion: nil)
        }
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFroemCamera)
        imagePickerAlertController.addAction(cancelAction)
        
        imagePickerAlertController.popoverPresentationController?.sourceView = myController.view
        imagePickerAlertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        myController.present(imagePickerAlertController, animated: true, completion: nil)
    }
}
