//
//  UpLodeViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/20.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class UpLodeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descripTextView: UITextView!
    
    var downloadDic:Dictionary = [String:Any]()
    var addingNewItemDic:Dictionary = [String:Any]()
    var allStory:Array = [Dictionary<String,Any>]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        myImageView.image = nil
        addressTextField.text = ""
        titleTextField.text = ""
        descripTextView.text = ""
    }
    

    @IBAction func imageSelectedButton(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let imageSelect = SelectImage()
        imageSelect.selsetImage(imagePickerController: imagePickerController, myController: self)
        func selsetImage(imagePickerController: UIImagePickerController, myController: UIViewController) {
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            myImageView.image = selectImage
            myImageView.contentMode = .scaleAspectFit
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
            
    @IBAction func doneButtonDidPressed(_ sender: UIBarButtonItem) {
        

        let alertaction = UIAlertController(title: "確定送出？", message: "", preferredStyle: .alert)
        alertaction.addAction(UIAlertAction(title: "確定", style: .default, handler: { (UIAlertAction) in
            self.upload()
            
        }))
        alertaction.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alertaction, animated: true, completion: nil)

    }
    
    func upload() {
        let ref = Database.database().reference()
        let storage = Storage.storage().reference()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.addressTextField.text!) {
            placemarks, error in
            let placemark = placemarks?.first
            guard let lat = placemark?.location?.coordinate.latitude, let lon = placemark?.location?.coordinate.longitude else {
                return
            }
            print("Lat: \(lat), Lon: \(lon)")
            self.addingNewItemDic.updateValue(lat, forKey: "latitude")
            self.addingNewItemDic.updateValue(lon, forKey: "longitude")
        }
        
        if let imageData = UIImageJPEGRepresentation(self.myImageView.image!, 0.5) {
            let tempData = imageData as NSData
            let imageLength = tempData.length
            guard imageLength < 1 * 1024 * 1024 else {
                print("檔案大小請勿超過1MB")
                return
            }
            let metaData = StorageMetadata()
            metaData.contentType = "jepg"
            storage.child("storyImage/\(Auth.auth().currentUser!.uid)/\(self.titleTextField.text!).jepg").putData(imageData, metadata: metaData, completion: { (metaData, error) in
                if error != nil {
                    print(error!.localizedDescription + "image error")
                }
                
                if self.titleTextField.text != "" && self.descripTextView.text != "" {
                    self.addingNewItemDic.updateValue(self.titleTextField.text!, forKey: "title")
                    self.addingNewItemDic.updateValue(self.descripTextView.text!, forKey: "description")
                }
                if let user = Auth.auth().currentUser!.email {
                    self.addingNewItemDic.updateValue(user, forKey: "user")
                }

                
                
                if let uploadImageUrl = metaData?.downloadURL()?.absoluteString {
                    // 我們可以 print 出來看看這個連結是不是我們剛剛所上傳的照片。
                    print("Photo Url: \(uploadImageUrl)")
                    self.addingNewItemDic.updateValue(uploadImageUrl, forKey: "url")
 
                    //加到Array後再上傳
                    self.allStory.append(self.addingNewItemDic)
                    ref.child("newStory").setValue(self.allStory, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            print(error!.localizedDescription)
                        } else {
                            print("上傳成功")
                            print(self.allStory)
                            
                            let alert = UIAlertController(title: "上傳成功", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    })
                }
            })
            
        }
    }
}
