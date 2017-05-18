//
//  AppDelegate.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/4/26.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //FB SDK 由 Object-C 改寫
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        UINavigationBar.appearance().tintColor = UIColor.white
        
        if let barFont = UIFont(name: "Avenir-Light", size: 24) {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: barFont]
        }

        
        
        //將statusbar顏色改為白色
        UINavigationBar.appearance().barStyle = .blackOpaque
        
        //把tabBarController改顏色
        let tabBarController = self.window?.rootViewController as! UITabBarController
        tabBarController.tabBar.tintColor = UIColor(red: 250/255, green: 127/255, blue: 127/255, alpha: 1)
        tabBarController.tabBar.unselectedItemTintColor = UIColor.gray
        
        //進入LaunchScreen延遲
        Thread.sleep(forTimeInterval: 7)
        
        return true
    }
    
    //FB SDK 由 Object-C 改寫
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

