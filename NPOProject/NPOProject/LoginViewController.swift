//
//  LoginViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/4/26.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {
    
    var window: UIWindow?
    
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //改登入按鈕外觀圓角
        loginButtonOutlet.layer.cornerRadius = 5
        loginButtonOutlet.clipsToBounds = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = "登入"
        
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
    
    @IBAction func loginButtonDidPressed(_ sender: UIButton) {
        guard let email = emailTextFiled.text, let password = passwordTextField.text else {
            print("Form is not vaild")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user: User?, error: Error?) in
            if error != nil {
                print(error!.localizedDescription)
                let alertAction = UIAlertController(title: "錯誤", message: "帳號或密碼錯誤", preferredStyle: .alert)
                alertAction.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(alertAction, animated: true, completion: nil)
                return
            } else {
                //帳密無誤，登入後跳轉畫面至故事牆
                let tabController = self.tabBarController
                tabController?.selectedIndex = 0
                let navController = tabController?.selectedViewController as? UINavigationController
                navController?.popToRootViewController(animated: true)
                print("登入成功")
            }
        })
    }
    
    //用臉書帳號登入
    @IBAction func LoginButton(_ sender: UIButton) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if let error = error {
                print("error login: \(error.localizedDescription)")
            }else{
                
                //拿到使用者臉書token
                guard let token = FBSDKAccessToken.current() else {
                    print("falid to get token")
                    return
                }
                if let tokenString = token.tokenString {
                    print(tokenString)
                    
                    //用臉書登入firebase
                    let credentail = FacebookAuthProvider.credential(withAccessToken: tokenString)
                    Auth.auth().signIn(with: credentail, completion: { (user: User?, error: Error?) in
                        if error != nil {
                            print(error!.localizedDescription)
                            return
                        } else {
                            print("成功用臉書登入")
                        }
                    })
                }
                print("**************Login ok******************")
                
                //拿到使用者臉書id, name, email
                let request = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email"])
                let _ = request?.start(completionHandler: {
                    (connection:FBSDKGraphRequestConnection?, result:Any?, error:Error?) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    if let okResult = result as? [String:String] {
                        print(okResult)
                        if let name = okResult["name"] {
                            print("welcome \(name)")
                            //帳密無誤，登入後跳轉畫面至故事牆
                            let tabController = self.tabBarController
                            tabController?.selectedIndex = 0
                            let navController = tabController?.selectedViewController as? UINavigationController
                            navController?.popToRootViewController(animated: true)
                        }
                    }
                })
            }
        }
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        emailTextFiled.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}
