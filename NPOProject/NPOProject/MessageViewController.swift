//
//  MessageViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/4.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit


class MessageViewController: UIViewController {
    
    let timeCalculate = TimeCalculate()
    

    var nickName = ["Jack Lin","Cid","midchen","Vivian","Chris", "Lucaus","Jay","Min","Ember","Edward","Miguel"]
    
    var message = [String]()
    var nickname = [String]()
    var time = [String]()
    let messageView = UIView()
    let nickNameLabel = UILabel()
    let nickNameTextField = UITextField()
    let messageLabel = UILabel()
    let messageTextView = UITextView()
    let sendMessageButton = UIButton(type: UIButtonType.custom) as UIButton
    
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var toolbarTextField: UITextField!
    
    @IBAction func toolbarSendButton(_ sender: UIBarButtonItem) {
        let randomNumber = Int(arc4random_uniform(11))
        if toolbarTextField.text != "" {
            nickname.insert(nickName[randomNumber], at: 0)
            message.insert(toolbarTextField.text!, at: 0)
            //送出留言存入當下的時間
            time.insert(timeCalculate.getToday(), at: 0)
        }
        UserDefaults.standard.set(nickname, forKey: "nickname")
        UserDefaults.standard.set(message, forKey: "message")
        UserDefaults.standard.set(time, forKey: "time")
        UserDefaults.standard.synchronize()

        toolbarTextField.resignFirstResponder()
        toolbarTextField.text = ""
        tableView.reloadData()
        
    }
    @IBOutlet weak var toolbarBottonLayout: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
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
    
        if let loadNickName = UserDefaults.standard.stringArray(forKey: "nickname") {
            nickname = loadNickName
        }
        if let loadmessage = UserDefaults.standard.stringArray(forKey: "message") {
            message = loadmessage
        }
        if let loadTime = UserDefaults.standard.stringArray(forKey: "time") {
            time = loadTime
        }
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
        return message.count
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let alertAction = UIAlertController(title: "確認刪除？", message: "", preferredStyle: .alert)
        alertAction.addAction(UIAlertAction(title: "取消", style: .default, handler: nil))
        alertAction.addAction(UIAlertAction(title: "刪除", style: .cancel, handler: { (UIAlertAction) in
            if editingStyle == .delete {
                // Delete the row from the data source
                self.nickname.remove(at: indexPath.row)
                self.message.remove(at: indexPath.row)
                self.time.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }))
        self.present(alertAction, animated: true, completion: nil)
    }
}

//MARK: - Table view data source
extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell
        cell.nickNameLabel.text = nickname[indexPath.row]
        cell.messageLable.text = message[indexPath.row]
        //計算出過去留言距離現在的時間
        cell.timeLable.text =  timeCalculate.compareDate(theDate: time[indexPath.row])
        UserDefaults.standard.set(nickname, forKey: "nickname")
        UserDefaults.standard.set(message, forKey: "message")
        UserDefaults.standard.set(time, forKey: "time")
        UserDefaults.standard.synchronize()
        return cell
    }
}
