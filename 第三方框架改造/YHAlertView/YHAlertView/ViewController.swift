//
//  ViewController.swift
//  YHAlertView
//
//  Created by samuelandkevin on 2017/5/22.
//  Copyright © 2017年 samuelandkevin. All rights reserved.
//  https://github.com/samuelandkevin/YHAlertView

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _setUpNavigationBar()
        _setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Method
    private func _setUpNavigationBar(){
        self.title = "YHAlertView"
        
        //设置导航栏背景颜色
        let color = UIColor(red: CGFloat(0) / 255.0, green: CGFloat(191) / 255.0, blue: CGFloat(143) / 255.0, alpha: CGFloat(1))
        navigationController?.navigationBar.barTintColor = color
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.init(white: 0.871, alpha: 1.000)
        shadow.shadowOffset = CGSize(width: 0.5, height: 0.5)
        shadow.shadowBlurRadius = 20
        
        //设置导航栏标题颜色
        let attributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSShadowAttributeName:shadow]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.isTranslucent = false
        
        //设置返回按钮的颜色
        UINavigationBar.appearance().tintColor = UIColor.white
        

    }
    
    private func _setupUI(){
        
        for i in 0..<5 {
            let btn = UIButton()
            btn.tag = 100 + i
            
            let w:CGFloat = 200
            let h:CGFloat = 60
            let x = (view.frame.size.width - w)/2
            let y = (h+10) * CGFloat(i) + CGFloat(10)
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            btn.backgroundColor = UIColor.orange
            btn.setTitle("样式 "+"\(i+1)", for: .normal)
            btn.addTarget(self, action: #selector(onBtn(sender:)), for: .touchUpInside)
            view.addSubview(btn)
        }
      
    }
    
    // MARK: - Action
    func onBtn(sender:UIButton){
        
        switch sender.tag {
            case 100:
                
                let message1 = "本功能将在约定还款日当天从您预设的银行卡中自动划扣每期应还的金额，让还款更省心。"
                let message2 = "查看《委托自动还款协议》"
                let messageStr = "\(message1)\n\(message2)"
                
                let messageText = NSMutableAttributedString.init(string: messageStr)
                
                let style1 = NSMutableParagraphStyle()
                style1.lineSpacing = 8 // 行距
                style1.alignment = .left
                // 段落设置
                messageText.addAttribute(NSParagraphStyleAttributeName, value: style1, range: NSRange.init(location: 0, length: message1.characters.count))
                let style2 = NSMutableParagraphStyle()
                style2.alignment = .center
                // 段落设置
                messageText.addAttribute(NSParagraphStyleAttributeName, value: style2, range: NSRange.init(location: message1.characters.count + 1, length: message2.characters.count))
                // 添加下划线
                let number = NSNumber(integerLiteral: NSUnderlineStyle.styleSingle.rawValue)
                let range = NSRange.init(location: message1.characters.count + 4, length: message2.characters.count - 4)
                messageText.addAttribute(NSUnderlineStyleAttributeName, value: number, range: range)
                messageText.addAttribute(NSFontAttributeName, value: UIFont.qqmSystemFont(ofSize: 14, weight: .thin), range: NSRange.init(location: 0, length: messageStr.characters.count))
                messageText.addAttribute(NSForegroundColorAttributeName, value: QQMColor3c4455, range: NSRange.init(location: 0, length: messageStr.characters.count))
                messageText.addAttribute(NSForegroundColorAttributeName, value: QQMColorff4444, range: NSRange.init(location: message1.characters.count + 1, length: message2.characters.count))
                
                let alert = QQMAlertHelp.getAlert(title: "当前银行卡尚未开通自动还款", messageAttributedString: messageText, buttonText1: "暂不开通", action1: {
                    print("暂不开通")
                }, buttonText2: "确认开通", action2: {
                    print("确认开通")
                })
                alert.clickUnderlineText(underlineTextRange: range, action: { (text) in
                    let textStr: String = text as! String
                    print(textStr)
                })
                alert.show()
                
                
                
//                let message1 = "非常遗憾，您的输入不正确"
//                let message2 = "*个人信息会进行加密处理"
//                let messageStr = "\(message1)\n\(message2)"
//                let style = NSMutableParagraphStyle()
//                style.lineSpacing = 8 // 行距
//                style.alignment = .center
//                let messageText = NSMutableAttributedString.init(string: messageStr)
//                // 字间距
//                messageText.addAttribute(NSKernAttributeName, value: 0.8, range: NSRange.init(location: 0, length: messageText.length))
//                // 段落设置
//                messageText.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange.init(location: 0, length: messageText.length))
//                messageText.addAttribute(NSForegroundColorAttributeName, value: QQMColorff4444, range: NSRange.init(location: message1.characters.count + 1, length: message2.characters.count))
//                
//                QQMAlertHelp.showAlert(title: nil, messageAttributedString: messageText, buttonText: "知道了", action: { 
//                    
//                })
//                QQMAlertHelp.showAlert(title: nil, messageAttributedString: messageText, buttonText1: "重新提交", action1: {
//                    print("取消")
//                }, buttonText2: "其他验证", action2: {
//                    print("删除")
//                })
                
//                QQMAlertHelp.showAlert(title: nil, message: "客服办公时间\n0900-1200\n1330-1830\n(节假日除外)", messageTextAlignment: .center, buttonText1: "返回", action1: {
//                    print("取消")
//                }, buttonText2: "马上联系", action2: {
//                    print("删除")
//                })
                
//                let html: String = "<p style='color: red; background-color: green; font-size: 30'>哈哈</p>"
//                let html: String =
//                "<html>" +
//                "  <head>" +
//                "    <style type='text/css'>" +
//                "      body { font: 16pt 'Gill Sans'; color: #1a004b; }" +
//                "      i { color: #822; }" +
//                "    </style>" +
//                "  </head>" +
//                "  <body>Here is some <i>formatting!</i></body>" +
//                "</html>"
//                
//                QQMAlertHelp.showAlert(title: nil, messageHtml: html, buttonText: "确定", action: { 
//                    
//                })
                
                
                
//                QQMAlertHelp.showAlert(title: "温馨提示", message: "资料认证不通过，请重新填写！", buttonText1: "取消", action1: {
//                    print("取消")
//                }, buttonText2: "立即填写", action2: {
//                    print("删除")
//                })
                
//                QQMAlertHelp.showAlert(title: "温馨提示", message: "确认是否删除？", buttonText1: "取消", action1: {
//                    print("取消")
//                }, buttonText2: "删除", action2: {
//                    print("删除")
//                })
                
                
//                QQMAlertHelp.showAlertKnow(message: "身份认证未完成，不可添加多张银行卡，请稍后再试~~")
//                QQMAlertHelp.showAlertKnow(message: "暂不支持该资料认证")
//                QQMAlertHelp.showAlertKnow(message: "通过人民银行征信中心验证后，征信中心会以短信的格式，将身份验证码发送给您，有效期为7天。若验证码过期，可重新获取。")
                

//                QQMAlertHelp.showAlert(title: nil, message: "银行预留手机号是您在办理银行卡时所填写的手机号。如忘记、停用或无预留手机号码，请拨打银行客服更新处理。", buttonText: "知道了", action: {
//                    print("知道了")
//                })
                
//                let alertV = QQMAlertView(title: nil, message: "银行预留手机号是您在办理银行卡时所填写的手机号。如忘记、停用或无预留手机号码，请拨打银行客服更新处理。", buttonTitle1: "取消", style1: .cancel, action1: { 
//                    print("取消")
//                }, buttonTitle2: "删除", style2: .confirm, action2: { 
//                    print("删除")
//                })
//                alertV.show()
                
//                let alertV = YHAlertView(title: nil, message: "银行预留手机号是您在办理银行卡时所填写的手机号。如忘记、停用或无预留手机号码，请拨打银行客服更新处理。", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: ["删除"])
//                alertV.show()
                
                // message 和 cancelBtn 为nil
//                YHAlertView.show(title: "YHAlertView", message: nil, cancelButtonTitle: nil, otherButtonTitle: "知道了") { (alertV:YHAlertView, index:Int) in
//                    print("点击下标是:\(index)")
//                }
                break
            case 101:
                
                QQMAlertHelp.showAlert(title: "删除", message: "是否将所有消息标记为已读", buttonText1: "取消", action1: {
                    print("取消")
                }, buttonText2: "删除", action2: {
                    print("删除")
                })
                
//                let alertV = YHAlertView(title: "删除", message: "是否将所有消息标记为已读", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: ["删除"])
//                alertV.show()
                
                
                
                // message 好长
//                YHAlertView.show(title: "YHAlertView", message: "消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊", cancelButtonTitle: "取消", otherButtonTitle: "确定") { (alertV:YHAlertView, index:Int) in
//                    print("点击下标是:\(index)")
//                }
                break
            case 102:
                QQMAlertHelp.showAlert(title: nil, message: "别太贪心~您已经在使用消费业务了", buttonText: "知道了", action: {
                    print("知道了")
                })
                
//                QQMAlertHelp.showAlert(title: "删除", message: "是否将所有消息标记为已读哈哈哈哈哈", buttonText1: "取消", action1: {
//                    print("取消")
//                }, buttonText2: "删除", action2: {
//                    print("删除")
//                })
                
//                YHAlertView.show(title: nil, message: "银行预留手机号是您在办理银行卡时所填写的手机号。如忘记、停用或无预留手机号码，请拨打银行客服更新处理。", cancelButtonTitle: nil, otherButtonTitle: "知道了") { (alertV:YHAlertView, index:Int) in
//                    print("点击下标是:\(index)")
//                }
                
                
                // 多选择弹框
//                YHAlertView.show(title: "YHAlertView", message: "多选择弹框", cancelButtonTitle: "取消", otherButtonTitles:"1","2","3","4","5","6") { (alertV:YHAlertView, index:Int) in
//                    print("点击下标是:\(index)")
//                }
                
                break
            case 103:
                
                QQMAlertHelp.showAlertKnow(message: "消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息好长啊啊啊消息")
                
//                YHAlertView.show(title: "收不到短信", message: "1.部分银行需要先开通网上支付功能\n2.请确保当前手机号为银行预留的手机号码\n3.若银行预留的手机号码已作废，请联系银行进行修改\n4.请检查短信是否被手机安全软件拦截", cancelButtonTitle: nil, otherButtonTitle: "知道了") { (alertV:YHAlertView, index:Int) in
//                    print("点击下标是:\(index)")
//                }
                
                //取消模糊背景
//                let alertV = YHAlertView(title: "YHAlertView", message: "取消模糊背景", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: ["确定"])
//                alertV.visual = false
//                alertV.show()

                break
            case 104:
                
                
                QQMAlertHelp.showAlertKnow(message: "就一句哈哈哈哈哈哈哈或")
                
//                let alertV = YHAlertView(title: "删除", message: "就俩字", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: ["确定"])
//                alertV.messageTextAlignment = .center
//                alertV.show()
                
//                let alertV = YHAlertView(title: "删除", message: "就俩字", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: ["删除"])
//                alertV.show()
                
                
            //取消弹出动画,改变背景颜色
//            let alertV = YHAlertView(title: "YHAlertView", message: "取消弹出动画,改变背景颜色", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: ["确定"])
//            alertV.visual = false
//            alertV.animationOption = .none
//            alertV.visualBGColor = UIColor.red
//            alertV.show()
            
            break
            
            default:
                break
        }
        
        
        
        
    }

   
}

// Mark: YHAlertViewDelegate
extension ViewController:YHAlertViewDelegate{
    func alertView(alertView: YHAlertView, clickedButtonAtIndex: Int) {
        print("点击下标是:\(clickedButtonAtIndex)")
    }
}




