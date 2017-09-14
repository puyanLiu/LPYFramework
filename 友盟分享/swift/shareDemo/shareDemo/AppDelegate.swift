//
//  AppDelegate.swift
//  shareDemo
//
//  Created by liupuyan on 2017/7/18.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UMSocialManager.default().openLog(true)
        // 设置友盟appkey
        UMSocialManager.default().umSocialAppkey = "576c902f67e58ec7e70042ac"
        
        confitUShareSettings()
        configUSharePlatforms()
        return true
    }
    
    func confitUShareSettings() {
//        UMSocialGlobal.shareInstance().isUsingWaterMark = true
//        UMSocialGlobal.shareInstance().isClearCacheWhenGetUserInfo = false
    }
    
    func configUSharePlatforms() {
        let redictUrl = "http://wx.queqianme.com/#/download";
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: "wx902c2549d58312fa", appSecret: "4f66678ceaba9c55184c44252e56d921", redirectURL: redictUrl)
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: "1104867099", appSecret: "Dw3tapVU6OErVSKz", redirectURL: redictUrl)
    }
    
    // 系统回调
    // iOS9以上调用
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
        let result = UMSocialManager.default().handleOpen(url, options: options)
        if !result {
            // 其他如支付等SDK的回调
        }
        return result
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
        let result = UMSocialManager.default().handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
        if !result {
            // 其他如支付等SDK的回调
        }
        return result
    }
    // 支持所有iOS系统
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result {
            // 其他如支付等SDK的回调
        }
        return result
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

