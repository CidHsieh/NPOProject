//
//  MessageViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/4.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit


class MessageViewController: UIViewController {
    
    var message:[String] = []
    var nickname:[String] = []
    var time:[String] = []
    let messageView = UIView()
    let nickNameLabel = UILabel()
    let nickNameTextField = UITextField()
    let messageLabel = UILabel()
    let messageTextView = UITextView()
    let sendMessageButton = UIButton(type: UIButtonType.custom) as UIButton
    


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        //點擊空白處退出鍵盤
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        messageView.addGestureRecognizer(touch)
        
        //兩個都要設才能自動調整高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //偵測鍵盤出現時改變view的高度
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    //鍵盤出現，view高度往上
    func keyBoardWillShow(notification: NSNotification) {
        //handle appearing of keyboard here
        self.view.frame = CGRect(x: 0, y: -70, width: view.frame.width, height: view.frame.height)
        
//        if let keyBoardHeight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size.height {
//            
//            let visible = view.frame.maxY - (keyBoardHeight + UIApplication.shared.statusBarFrame.height)
//            print(visible)
//            print(sendMessageButton.frame.maxY)
//            if sendMessageButton.frame.maxY + messageView.frame.minY > visible {
//                let moveHeight = sendMessageButton.frame.maxY - visible
//                view.frame.origin.y += moveHeight
//            }
//        }
    }
    //鍵盤退出，view高度往下
    func keyBoardWillHide(notification: NSNotification) {
        //handle dismiss of keyboard here
        self.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    func getToday(format:String = "yyyy/MM/dd HH:mm:ss") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    func messageViewLayout() {
        messageView.backgroundColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        self.view.addSubview(messageView)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: messageView, attribute: .width, relatedBy: .equal, toItem: tableView, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: messageView, attribute: .height, relatedBy: .equal, toItem: tableView, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: messageView, attribute: .leading, relatedBy: .equal, toItem: tableView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: messageView, attribute: .top, relatedBy: .equal, toItem: tableView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func nickNameTextFieldLayout() {
        nickNameTextField.backgroundColor = UIColor.white
        nickNameTextField.layer.cornerRadius = 5
        nickNameTextField.clipsToBounds = true
        nickNameTextField.font = UIFont(name: "Avenir-Light", size: 20)
        self.messageView.addSubview(nickNameTextField)
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: nickNameTextField, attribute: .leading, relatedBy: .equal, toItem: messageView, attribute: .leading, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: nickNameTextField, attribute: .top, relatedBy: .equal, toItem: messageView, attribute: .top, multiplier: 1.0, constant: 50).isActive = true
        NSLayoutConstraint(item: nickNameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150).isActive = true
        NSLayoutConstraint(item: nickNameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
    }
    func nickNameLableLayout() {
        nickNameLabel.text = "暱稱"
        self.messageView.addSubview(nickNameLabel)
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: nickNameLabel, attribute: .leading, relatedBy: .equal, toItem: nickNameTextField, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: nickNameLabel, attribute: .bottom, relatedBy: .equal, toItem: nickNameTextField, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: nickNameLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
        NSLayoutConstraint(item: nickNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
    }
    func messageLableLayout() {
        messageLabel.text = "留言內容"
        self.messageView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: nickNameTextField, attribute: .bottom, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: messageLabel, attribute: .leading, relatedBy: .equal, toItem: nickNameTextField, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
        NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
    }
    func messageTextFieldLayout() {
        messageTextView.backgroundColor = UIColor.white
        messageTextView.layer.cornerRadius = 5
        messageTextView.clipsToBounds = true
        messageTextView.font = UIFont(name: "Avenir-Light", size: 20)
        self.messageView.addSubview(messageTextView)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: messageTextView, attribute: .leading, relatedBy: .equal, toItem: messageLabel, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: messageTextView, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: messageTextView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300).isActive = true
        NSLayoutConstraint(item: messageTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150).isActive = true
    }
    func sendButtonLayout() {
        sendMessageButton.setTitle("送出", for: .normal)
        sendMessageButton.addTarget(self, action: #selector(sendButtonDidPressed), for: .touchUpInside)
        sendMessageButton.setTitleColor(UIColor.white, for: .normal)
        sendMessageButton.translatesAutoresizingMaskIntoConstraints = false
        self.messageView.addSubview(sendMessageButton)
        NSLayoutConstraint(item: sendMessageButton, attribute: .top, relatedBy: .equal, toItem: messageTextView, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: sendMessageButton, attribute: .centerX, relatedBy: .equal, toItem: messageView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: sendMessageButton, attribute: .width, relatedBy: .equal
            , toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50).isActive = true
        NSLayoutConstraint(item: sendMessageButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
    }
    
    func sendButtonDidPressed() {
//        self.dismiss(animated: true, completion: nil)
        if nickNameTextField.text != "" && messageTextView.text != "" {
            message.insert(messageTextView.text!, at: 0)
            nickname.insert(nickNameTextField.text!, at: 0)
            let today = getToday()
            time.insert("\(today)", at: 0)
            tableView.reloadData()
        }
        messageView.removeFromSuperview()
        messageTextView.text = ""
        nickNameTextField.text = ""
    }
    
    @IBAction func messageButtonDidPressed(_ sender: UIButton) {
        messageViewLayout()
        nickNameTextFieldLayout()
        nickNameLableLayout()
        messageLableLayout()
        messageTextFieldLayout()
        sendButtonLayout()
//        nickNameTextField.becomeFirstResponder()
    }
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        nickNameTextField.resignFirstResponder()
        messageTextView.resignFirstResponder()
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
}

//MARK: - Table view data source
extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell
        cell.nickNameLabel.text = nickname[indexPath.row]
        cell.messageLable.text = message[indexPath.row]
        cell.timeLable.text = time[indexPath.row]
        return cell
    }
}
