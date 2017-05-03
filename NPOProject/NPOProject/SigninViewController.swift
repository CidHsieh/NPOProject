//
//  SigninViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var signinButtonOutlet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "註冊"
        //註冊按鈕改圓角
        signinButtonOutlet.layer.cornerRadius = 5
        signinButtonOutlet.clipsToBounds = true
        
        //點擊空白處退出鍵盤
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        view.addGestureRecognizer(touch)
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
    }
    //鍵盤退出，view高度往下
    func keyBoardWillHide(notification: NSNotification) {
        //handle dismiss of keyboard here
        self.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    @IBAction func singinButtonDidPressed(_ sender: UIButton) {
        
    }
    func tap(gesture: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPassword.resignFirstResponder()
        
    }

    

}
