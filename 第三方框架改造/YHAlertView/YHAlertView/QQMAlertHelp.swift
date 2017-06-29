//
//  QQMAlertHelp.swift
//  YHAlertView
//
//  Created by liupuyan on 2017/6/27.
//  Copyright © 2017年 samuelandkevin. All rights reserved.
//

import UIKit

class QQMAlertHelp: NSObject {
    
    /// 知道了按钮
    ///
    /// - Parameter message: <#message description#>
    class func showAlertKnow(message: String) {
        showAlert(title: nil, message: message, buttonText: "知道了", action: nil)
    }
    
    /// 单个按钮
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - buttonText: <#buttonText description#>
    ///   - action: <#action description#>
    class func showAlert(title: String?, message: String?, buttonText: String, action: OperationBlock?) {
        let alertV = QQMAlertView(title: title, message: message, buttonTitle1: buttonText, style1: .confirm, action1: action, buttonTitle2: nil, style2: nil, action2: nil)
        alertV.show()
    }
    
    /// 两个按钮
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - buttonText1: <#buttonText1 description#>
    ///   - action1: <#action1 description#>
    ///   - buttonText2: <#buttonText2 description#>
    ///   - action2: <#action2 description#>
    class func showAlert(title: String?, message: String?, buttonText1: String, action1: OperationBlock?, buttonText2: String, action2: OperationBlock?) {
        let alertV = QQMAlertView(title: title, message: message, buttonTitle1: buttonText1, style1: .cancel, action1: action1, buttonTitle2: buttonText2, style2: .confirm, action2: action2)
        alertV.show()
    }
    
    /// 单个按钮 html
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - buttonText: <#buttonText description#>
    ///   - action: <#action description#>
    class func showAlert(title: String?, messageHtml: String?, buttonText: String, action: OperationBlock?) {
        let alertV = QQMAlertView(title: title, messageHtml: messageHtml, buttonTitle1: buttonText, style1: .confirm, action1: action, buttonTitle2: nil, style2: nil, action2: nil)
        alertV.show()
    }
    
    /// 两个按钮 html
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - buttonText1: <#buttonText1 description#>
    ///   - action1: <#action1 description#>
    ///   - buttonText2: <#buttonText2 description#>
    ///   - action2: <#action2 description#>
    class func showAlert(title: String?, messageHtml: String?, buttonText1: String, action1: OperationBlock?, buttonText2: String, action2: OperationBlock?) {
        let alertV = QQMAlertView(title: title, messageHtml: messageHtml, buttonTitle1: buttonText1, style1: .cancel, action1: action1, buttonTitle2: buttonText2, style2: .confirm, action2: action2)
        alertV.show()
    }
    
    /// 两个按钮
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - buttonText1: <#buttonText1 description#>
    ///   - action1: <#action1 description#>
    ///   - buttonText2: <#buttonText2 description#>
    ///   - action2: <#action2 description#>
    class func showAlert(title: String?, message: String?, messageTextAlignment: NSTextAlignment, buttonText1: String, action1: OperationBlock?, buttonText2: String, action2: OperationBlock?) {
        let alertV = QQMAlertView(title: title, message: message, messageTextAlignment: messageTextAlignment, buttonTitle1: buttonText1, style1: .cancel, action1: action1, buttonTitle2: buttonText2, style2: .confirm, action2: action2)
        alertV.show()
    }
    
    /// 单个按钮 富文本
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - buttonText1: <#buttonText1 description#>
    ///   - action1: <#action1 description#>
    ///   - buttonText2: <#buttonText2 description#>
    ///   - action2: <#action2 description#>
    class func showAlert(title: String?, messageAttributedString: NSAttributedString, buttonText: String, action: OperationBlock?) {
        let alertV = QQMAlertView(title: title, messageAttributedString: messageAttributedString, buttonTitle1: buttonText, style1: .confirm, action1: action, buttonTitle2: nil, style2: nil, action2: nil)
        alertV.show()
    }
    
    /// 两个按钮 富文本
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - buttonText1: <#buttonText1 description#>
    ///   - action1: <#action1 description#>
    ///   - buttonText2: <#buttonText2 description#>
    ///   - action2: <#action2 description#>
    class func showAlert(title: String?, messageAttributedString: NSAttributedString, buttonText1: String, action1: OperationBlock?, buttonText2: String, action2: OperationBlock?) {
        let alertV = QQMAlertView(title: title, messageAttributedString: messageAttributedString, buttonTitle1: buttonText1, style1: .cancel, action1: action1, buttonTitle2: buttonText2, style2: .confirm, action2: action2)
        alertV.show()
    }
    
    /// 两个按钮 富文本
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - buttonText1: <#buttonText1 description#>
    ///   - action1: <#action1 description#>
    ///   - buttonText2: <#buttonText2 description#>
    ///   - action2: <#action2 description#>
    class func getAlert(title: String?, messageAttributedString: NSAttributedString, buttonText1: String, action1: OperationBlock?, buttonText2: String, action2: OperationBlock?) -> QQMAlertView {
        return QQMAlertView(title: title, messageAttributedString: messageAttributedString, buttonTitle1: buttonText1, style1: .cancel, action1: action1, buttonTitle2: buttonText2, style2: .confirm, action2: action2)
    }
}
