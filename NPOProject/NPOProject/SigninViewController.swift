//
//  SigninViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/2.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import Firebase


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
    //按下註冊按鈕
    @IBAction func singinButtonDidPressed(_ sender: UIButton) {
        if passwordTextField.text == confirmPassword.text {
            guard let email = emailTextField.text, let password = passwordTextField.text else {
                print("Form is not vaild")
                return
            }
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error: Error?) in
                if error != nil {
                    print(error!.localizedDescription)
                    let alertAction = UIAlertController(title: "Error!", message: error!.localizedDescription, preferredStyle: .alert)
                    alertAction.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alertAction, animated: true, completion: nil)
                    return
                } else {
                    print("順利新增使用者")
                    self.navigationController?.popViewController(animated: true)
                }
            })

        } else {
            let alertAction = UIAlertController(title: "錯誤", message: "請再次確認密碼", preferredStyle: .alert)
            alertAction.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alertAction, animated: true, completion: nil)
            return
        }
        
    }
    func tap(gesture: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPassword.resignFirstResponder()        
    }

    

}
