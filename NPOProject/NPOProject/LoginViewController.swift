//
//  LoginViewController.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/4/26.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import FBSDKLoginKit

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
        navigationItem.title = "呆丸眉角"
    }
    
    @IBAction func loginButtonDidPressed(_ sender: UIButton) {
//        let jsonString = "email=\(emailTextFiled.text!)&password=\(passwordTextField.text!)"
        // create post request
        let url = URL(string: "http://172.104.45.242/api/v1/login?" + "email=\(emailTextFiled.text!)&password=\(passwordTextField.text!)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        
        // insert json data to the request
//        request.httpBody = jsonString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            if let result = String(data: data, encoding: .utf8) {
                let token = result
                if token.contains("email or password is not correct") != true {
                    
                    //帳密無誤，登入後跳轉畫面至故事牆
                    let tabController = self.tabBarController
                    tabController?.selectedIndex = 0
                    let navController = tabController?.selectedViewController as? UINavigationController
                    navController?.popToRootViewController(animated: true)
                    
                } else {
                    //帳密錯誤
                    let alertAction = UIAlertController(title: "帳號/密碼 輸入錯誤", message: "您輸入帳號或密碼不正確，請再輸入一次", preferredStyle: .alert)
                    alertAction.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                        self.present(alertAction, animated: true, completion: nil)
                    print("帳密錯誤")
                }
                print(token)
            }
        }
        task.resume()
        
        
        print("\(emailTextFiled.text!), \(passwordTextField.text!)")
        
        
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        let fbLogoutManager = FBSDKLoginManager()
        fbLogoutManager.logOut()
        print("**************Logout ok******************")
        
        
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
                    
                    //let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    //let blueController = storyboard.instantiateViewController(withIdentifier: "ViewController")
                    //navController?.pushViewController(blueController, animated: false)
                    //navController?.popToRootViewController(animated: true)

                    
                    
//                    let navigationController = self.tabBarController?.viewControllers?.first as? UINavigationController
//                    if let viewController = navigationController?.viewControllers {
//                        let firstViewController = viewController.first as! ViewController
//                        
//                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//                        let pushView = storyboard.instantiateViewController(withIdentifier: "ViewController")
//                        firstViewController.navigationController?.pushViewController(pushView, animated: true)
//                    }
                    
                })
                
            }
        }
    }
}
