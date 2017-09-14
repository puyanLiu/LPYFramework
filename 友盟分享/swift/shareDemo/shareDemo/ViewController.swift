//
//  ViewController.swift
//  shareDemo
//
//  Created by liupuyan on 2017/7/18.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

import UIKit

let UMS_Title = "【友盟+】社会化组件U-Share";
let UMS_Prog_Title = "【友盟+】U-Share小程序";
let UMS_Text = "欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";
let UMS_Text_image = "i欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";
let UMS_Web_Desc = "W欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";
let UMS_Music_Desc = "M欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";
let UMS_Video_Desc = "V欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";

let UMS_THUMB_IMAGE = "https://mobile.umeng.com/images/pic/home/social/img-1.png";
let UMS_IMAGE = "https://mobile.umeng.com/images/pic/home/social/img-1.png";

let UMS_WebLink = "https://bbs.umeng.com/";

let UMS_SHARE_TBL_CELL = "UMS_SHARE_TBL_CELL";

class ViewController: UIViewController {

    @IBAction func btn_Wechat(_ sender: Any) {
        
        if !(UIApplication.shared.canOpenURL(NSURL.init(string: "wechat://")! as URL) && UIApplication.shared.canOpenURL(NSURL.init(string: "weixin://")! as URL)) {
            print("未安装")
            return
        }
        
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        // 分享文本
        //设置文本
//        messageObject.text = UMS_Text
        
        // 分享图片
//        // 创建图片对象内容
//        let shareObject = UMShareImageObject()
//        // 如果有缩略图则设置缩略图本地
//        shareObject.thumbImage = UIImage(named: "bg_mine")
//        shareObject.shareImage = UIImage(named: "LoginHeader")
//        messageObject.shareObject = shareObject
        
        // 分享网络图片
//        let shareObject = UMShareImageObject()
//        shareObject.thumbImage = UMS_THUMB_IMAGE
//        shareObject.shareImage = UMS_IMAGE
//        messageObject.shareObject = shareObject

        // 网页分享
        let thumbUrl = UMS_THUMB_IMAGE
        //创建网页内容对象
        let shareObject = UMShareWebpageObject.shareObject(withTitle: UMS_Title, descr: UMS_Web_Desc, thumImage: thumbUrl)
        // 设置网页地址
        shareObject?.webpageUrl = UMS_WebLink
        // 分享晓娣对象设置分享内容对象
        messageObject.shareObject = shareObject
        
        UMSocialSwiftInterface.share(plattype: UMSocialPlatformType.wechatSession, messageObject: messageObject, viewController: self) { (data, error) in
            if (error != nil) {
                print(error ?? NSError.self)
            } else {
                let d: UMSocialShareResponse = data as! UMSocialShareResponse
                if d.isKind(of: UMSocialShareResponse.self) {
                    let resp: UMSocialShareResponse = d
                    print("------------------", resp.message)
                    print("~~~~~~~~~~~~~~~", resp.originalResponse)
                } else {
                    print("================",d)
                }
            }
        }
        
    }
    
    @IBAction func btn_Pengyouquan(_ sender: Any) {
        if !(UIApplication.shared.canOpenURL(NSURL.init(string: "wechat://")! as URL) && UIApplication.shared.canOpenURL(NSURL.init(string: "weixin://")! as URL)) {
            print("未安装")
            return
        }
        
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        //设置文本
        messageObject.text = UMS_Text
        
        UMSocialSwiftInterface.share(plattype: UMSocialPlatformType.wechatTimeLine, messageObject: messageObject, viewController: self) { (data, error) in
            if (error != nil) {
                print(error ?? NSError.self)
            } else {
                let d: UMSocialShareResponse = data as! UMSocialShareResponse
                if d.isKind(of: UMSocialShareResponse.self) {
                    let resp: UMSocialShareResponse = d
                    print(resp.message)
                    print(resp.originalResponse)
                } else {
                    print("================",d)
                }
            }
        }
    }
    
    @IBAction func btn_QQ(_ sender: Any) {
        if !(UIApplication.shared.canOpenURL(NSURL.init(string: "mqq://")! as URL) && UIApplication.shared.canOpenURL(NSURL.init(string: "mqqapi://")! as URL)) {
            print("未安装")
            return
        }
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        //设置文本
        messageObject.text = UMS_Text
        
        UMSocialSwiftInterface.share(plattype: UMSocialPlatformType.QQ, messageObject: messageObject, viewController: self) { (data, error) in
            if (error != nil) {
                print(error ?? NSError.self)
            } else {
                let d: UMSocialShareResponse = data as! UMSocialShareResponse
                if d.isKind(of: UMSocialShareResponse.self) {
                    let resp: UMSocialShareResponse = d
                    print(resp.message)
                    print(resp.originalResponse)
                } else {
                    print("================",d)
                }
            }
        }
    }
    
    @IBAction func btn_QQkongjian(_ sender: Any) {
        if !(UIApplication.shared.canOpenURL(NSURL.init(string: "mqq://")! as URL) && UIApplication.shared.canOpenURL(NSURL.init(string: "mqqapi://")! as URL)) {
            print("未安装")
            return
        }
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        //设置文本
        messageObject.text = UMS_Text
        
        UMSocialSwiftInterface.share(plattype: UMSocialPlatformType.qzone, messageObject: messageObject, viewController: self) { (data, error) in
            if (error != nil) {
                print(error ?? NSError.self)
            } else {
                let d: UMSocialShareResponse = data as! UMSocialShareResponse
                if d.isKind(of: UMSocialShareResponse.self) {
                    let resp: UMSocialShareResponse = d
                    print(resp.message)
                    print(resp.originalResponse)
                } else {
                    print("================",d)
                }
            }
        }
    }
    
    
}

