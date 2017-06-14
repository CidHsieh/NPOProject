//
//  MyProfileViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/19.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import Firebase


class MyProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet weak var selectPictureOutlet: UIButton!

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var editAndSaveOutlet: UIButton!
    
    let ref = Database.database().reference()
    let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //取用使用者暱稱
        ref.child("userinformation/\(Auth.auth().currentUser!.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let userInformation = snapshot.value as? Dictionary<String, Any> {
                print(userInformation)
                self.nickNameLabel.text = userInformation["nickName"] as? String
            }
        })
        emailLabel.text = Auth.auth().currentUser?.email
        storage.child("userImage/\(Auth.auth().currentUser!.uid).jpg").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if error != nil {
                print(error!.localizedDescription + "loading image error")
            } else {
                let image = UIImage(data: data!)
                self.myImageView.image = image
                self.myImageView.layer.cornerRadius = self.myImageView.frame.width / 2
                self.myImageView.clipsToBounds = true
                self.myImageView.contentMode = .scaleAspectFill
                
            }
            
        }
        
    }
    //選擇照片
    @IBAction func selectPicture(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let imageSelect = SelectImage()
        imageSelect.selsetImage(imagePickerController: imagePickerController, myController: self)
        func selsetImage(imagePickerController: UIImagePickerController, myController: UIViewController) {
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                let tempData = imageData as NSData
                let imageLength = tempData.length
                guard imageLength < 1 * 1024 * 1024 else {
                    print("檔案大小請勿超過1MB")
                    return
                }
                let metaData = StorageMetadata()
                metaData.contentType = "jepg"
                storage.child("userImage/\(Auth.auth().currentUser!.uid).jpg").putData(imageData, metadata: metaData, completion: { (metaData, error) in
                    if error != nil {
                        print(error!.localizedDescription + "image error")
                    }
                    //上傳成功才做的事
                    self.myImageView.image = image
                    self.myImageView.layer.cornerRadius = self.myImageView.frame.width / 2
                    self.myImageView.contentMode = .scaleAspectFill
                    self.myImageView.clipsToBounds = true
                    self.dismiss(animated: true, completion: nil)
                    
                    
                    //連結取得方式就是：data?.downloadURL()?.absoluteString
                    if let uploadImageUrl = metaData?.downloadURL()?.absoluteString {
                        // 我們可以 print 出來看看這個連結是不是我們剛剛所上傳的照片。
                        print("Photo Url: \(uploadImageUrl)")
                        self.ref.child("userinformation/\(Auth.auth().currentUser!.uid)/userImageUrl").setValue(uploadImageUrl, withCompletionBlock: { (error, ref) in
                            if error != nil {
                                print(error!.localizedDescription + "Database Error")
                            } else {
                                print("圖片已儲存")
                            }
                            
                        })
                    }
                })
                storage.child("storyImage/\(Auth.auth().currentUser!.uid).jpg").putData(imageData, metadata: metaData, completion: { (metadata, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                })
            }
        }
    }
    @IBAction func editAndSaveButton(_ sender: UIButton) {
        if sender.title(for: .normal) == "編輯" {
            nickNameLabel.isHidden = true
            nickNameTextField.isHidden = false
            nickNameTextField.text = nickNameLabel.text
            selectPictureOutlet.isHidden = false
            sender.setTitle("確定", for: .normal)
            sender.setTitleColor(UIColor.red, for: .normal)
        } else {
            guard nickNameTextField.text != "" else {
                return
            }
            ref.child("userinformation/\(Auth.auth().currentUser!.uid)/nickName").setValue(nickNameTextField.text, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error!.localizedDescription + "save error")
                } else {
                    self.nickNameLabel.isHidden = false
                    self.nickNameTextField.isHidden = true
                    self.nickNameLabel.text = self.nickNameTextField.text
                    self.nickNameTextField.text = ""
                    self.selectPictureOutlet.isHidden = true
                    sender.setTitle("編輯", for: .normal)
                    sender.setTitleColor(UIColor.blue, for: .normal)
                }
            })
        }
        
    }

    

}
