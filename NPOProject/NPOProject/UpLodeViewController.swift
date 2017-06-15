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
import NVActivityIndicatorView


class UpLodeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descripTextView: UITextView!
    
    var downloadDic:Dictionary = [String:Any]()
    var addingNewItemDic:Dictionary = [String:Any]()
    var allStory:Array = [Dictionary<String,Any>]()
    
    let activaty = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2, width: 80, height: 80), type: NVActivityIndicatorType.ballSpinFadeLoader, color: .red)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        
        activaty.center = self.view.center
        // 啟動 NVActivityIndicatorView 動畫
        self.view.addSubview(activaty)
        
        //點擊空白處退出鍵盤
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        view.addGestureRecognizer(touch)
    }
    
    //畫面出現時都先下載目前最新的array
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let ref = Database.database().reference()
        ref.child("newStory").observeSingleEvent(of: .value, with: { (snapshot) in
            if let newStory = snapshot.value as? [Dictionary<String,Any>] {
                self.allStory = newStory
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //偵測鍵盤出現時改變view的高度
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    //鍵盤出現，view高度往上
    func keyBoardWillShow(notification: NSNotification) {
        //handle appearing of keyboard here
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardFrame.height)
            if view.frame.height == 667 {
                self.view.frame = CGRect(x: 0, y: -160, width: view.frame.width, height: view.frame.height)
            } else if view.frame.height == 736 {
                self.view.frame = CGRect(x: 0, y: -150, width: view.frame.width, height: view.frame.height)
            }
        }
        
    }
    //鍵盤退出，view高度往下
    func keyBoardWillHide(notification: NSNotification) {
        //handle dismiss of keyboard here
        self.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
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
        //先確認是否已登入
        if UserDefaults.standard.bool(forKey: "isLogin") {
            //在判斷是否輸入完整資訊
            if myImageView.image != nil && addressTextField.text != "" && titleTextField.text != "" && descripTextView.text != "" {
                
                let alertaction = UIAlertController(title: "確定送出？", message: "", preferredStyle: .alert)
                alertaction.addAction(UIAlertAction(title: "確定", style: .default, handler: { (UIAlertAction) in
                    self.upload()
                    
                }))
                alertaction.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                self.present(alertaction, animated: true, completion: nil)
                
            } else {
                let alertaction = UIAlertController(title: "資料還沒填寫完成喔", message: "", preferredStyle: .alert)
                alertaction.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
                self.present(alertaction, animated: true, completion: nil)
            }
            
        } else {
            let alertaction = UIAlertController(title: "請先登入", message: "", preferredStyle: .alert)
            alertaction.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
            self.present(alertaction, animated: true, completion: nil)
        }
        
        

        

    }
    
    func upload() {
        activaty.startAnimating()
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
                            self.activaty.stopAnimating()
                            
                            let alert = UIAlertController(title: "上傳成功", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                            //上傳完成後清空文字匡
                            self.myImageView.image = nil
                            self.addressTextField.text = ""
                            self.titleTextField.text = ""
                            self.descripTextView.text = ""

                            
                        }
                    })
                }
            })
            
        }
        
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        addressTextField.resignFirstResponder()
        titleTextField.resignFirstResponder()
        descripTextView.resignFirstResponder()
    }
}
