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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if let error = error {
                print("error login: \(error.localizedDescription)")
            }else{
                guard let token = FBSDKAccessToken.current() else {
                    print("falid to get token")
                    
                    return
                }
                if let tokenString = token.tokenString {
                    print(tokenString)
                }
                print("**************Login ok******************")
                let request = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email"])
                let _ = request?.start(completionHandler: {
                    (connection:FBSDKGraphRequestConnection?, result:Any?, error:Error?) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    if let okResult = result as? [String:String] {
                        print(okResult)
                    }
                })
            }
        }
    }
}
