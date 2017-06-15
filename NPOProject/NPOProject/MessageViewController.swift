//
//  MessageViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/4.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UIViewController {
    
    let timeCalculate = TimeCalculate()
    
    var messageArray = [[String]]()
    
    let ref = Database.database().reference()
    
    var allStory:Array = [Dictionary<String,Any>]()
    var index = 0
    var story = Dictionary<String,Any>()
    var userNickmane = ""
    var userImageUrl = ""
    var newMessage = [String]()
    
    
    let nickNameLabel = UILabel()
    let nickNameTextField = UITextField()
    let messageLabel = UILabel()
    let messageTextView = UITextView()
    let sendMessageButton = UIButton(type: UIButtonType.custom) as UIButton
    
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var toolbarTextField: UITextField!
    
    @IBAction func toolbarSendButton(_ sender: UIBarButtonItem) {
        //先確認是否已登入
        if UserDefaults.standard.bool(forKey: "isLogin") {
            if toolbarTextField.text != "" {
                //將留言資訊存入messageArray
                
                newMessage.append(userNickmane)
                newMessage.append(toolbarTextField.text!)
                newMessage.append(timeCalculate.getToday())
                newMessage.append(userImageUrl)
                
                messageArray.insert(newMessage, at: 0)
            }
            story.updateValue(messageArray, forKey: "message")
            allStory[index] = story
            let ref = Database.database().reference()
            ref.child("newStory").setValue(self.allStory, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    print("留言成功")
                }
            })

            toolbarTextField.resignFirstResponder()
            toolbarTextField.text = ""
            tableView.reloadData()
        } else {
            let alertaction = UIAlertController(title: "請先登入", message: "", preferredStyle: .alert)
            alertaction.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
            self.present(alertaction, animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet weak var toolbarBottonLayout: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        ref.child("newStory").observeSingleEvent(of: .value, with: { (snapshot) in
            if let newStory = snapshot.value as? [Dictionary<String,Any>] {
                self.allStory = newStory
//                print(self.allStory[self.index])
                self.story = self.allStory[self.index]
                print(self.story)
                if let tempMessageArray = self.story["message"] as? [[String]] {
                    self.messageArray = tempMessageArray
                    print(self.messageArray)
                    self.tableView.reloadData()
                }
            }
        })
        
        //取得使用者暱稱
        ref.child("userinformation/\(Auth.auth().currentUser!.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let userInformation = snapshot.value as? Dictionary<String, Any> {
                print(userInformation)
                if let tmpeNickNmae = userInformation["nickName"] as? String {
                    self.userNickmane = tmpeNickNmae
                }
                if let tempImageUrl = userInformation["userImageUrl"] as? String {
                    self.userImageUrl = tempImageUrl
                }
            }
        })
        
        
        //點擊空白處退出鍵盤
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        tableView.addGestureRecognizer(touch)
        
        //兩個都要設才能自動調整高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        
        tableView.reloadData()
        
        //接收鍵盤出現時要做什麼動作
        NotificationCenter.default.addObserver(self, selector: #selector(MessageViewController.keyboardShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MessageViewController.keyboardHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        toolbarTextField.becomeFirstResponder()
    

    }
    
 
    //鍵盤出現時量測高度
    func keyboardShow(notification:Notification) {
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardFrame.height)
            if view.frame.height == 667 {
                toolbarBottonLayout.constant = 258
            } else if view.frame.height == 736 {
                toolbarBottonLayout.constant = 271
            }
            
        }
    }
    func keyboardHide(notification:Notification) {
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardFrame.height)
            toolbarBottonLayout.constant = 0
        }
    }
    
    
    
    
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        toolbarTextField.resignFirstResponder()
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        toolbarTextField.resignFirstResponder()
        
    }
}




//MARK: - Table view delegate

extension MessageViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
}

//MARK: - Table view data source
extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell
        cell.nickNameLabel.text = messageArray[indexPath.row][0]
        cell.messageLable.text = messageArray[indexPath.row][1]
        //計算出過去留言距離現在的時間
        cell.timeLable.text =  timeCalculate.compareDate(theDate: messageArray[indexPath.row][2])
        
        //把下載網址變成 URL，用 URL 去呼叫 loadImageWithURL 的方法
        if let imageURL = URL(string: messageArray[indexPath.row][3]) {
            let download = ImageDownLoad()
            download.loadImageWithURL(url: imageURL, myImageView: cell.userImage)
        }

        return cell
    }
}
