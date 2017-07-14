//
//  ViewController.swift
//  YKScrollRulerSwift
//
//  Created by Daniel Yao on 16/11/22.
//  Copyright © 2016年 Daniel Yao. All rights reserved.
//

import UIKit
// 屏幕宽度
let ScreenWidth = UIScreen.main.bounds.width
// 屏幕高度
let ScreenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController {
    
    lazy var sview:QQMScrollRulerView = { [unowned self] in
        let view = QQMScrollRulerView(frame: CGRect.init(x: 0, y: 20, width: ScreenWidth, height: 100), minValue: 0, maxValue: 1000, step: 10, unit: "", betweenNumber: 10)
        view.delegate = self
        return view
        }()
    
    lazy var sview1:QQMScrollRulerView = { [unowned self] in
        let view = QQMScrollRulerView(frame: CGRect.init(x: 0, y: 120, width: ScreenWidth, height: 100), minValue: 0, maxValue: 30, step: 1, unit: "", betweenNumber: 10)
        view.delegate = self
        return view
        }()
    
    lazy var sview2:QQMScrollRulerView = { [unowned self] in
        let view = QQMScrollRulerView(frame: CGRect.init(x: 0, y: 220, width: ScreenWidth, height: 100), minValue: 0, maxValue: 24, step: 1, unit: "", betweenNumber: 10)
        view.delegate = self
        return view
        }()
    
    lazy var textField: UITextField = {[unowned self] in
        let text = UITextField(frame: CGRect.init(x: 0, y: 400, width: ScreenWidth, height: 20))
        text.isUserInteractionEnabled  = true
        text.defaultTextAttributes     = [NSFontAttributeName:UIFont.systemFont(ofSize: 19)]
        text.textAlignment = NSTextAlignment.center
        text.delegate      = self
        text.keyboardType  = UIKeyboardType.phonePad
        text.backgroundColor = UIColor.gray
        return text
        }()
    
    
    lazy var lazyRulerView:DYScrollRulerView = { [unowned self] in
        let unitStr     = ""
        let rulerHeight = DYScrollRulerView.rulerViewHeight
        print(rulerHeight)
        var rulerView   = DYScrollRulerView.init(frame: CGRect.init(x: 5, y: 4500, width: Int(ScreenWidth)-20, height: rulerHeight()), tminValue: 0, tmaxValue: 1000, tstep: 10, tunit: unitStr, tNum:10)
        rulerView.bgColor       = UIColor.cyan
        rulerView.triangleColor = UIColor.red
        rulerView.delegate      = self
        rulerView.scrollByHand  = true
       return rulerView
    }()
    
    lazy var lazyTimeRullerView:DYScrollRulerView = { [unowned self] in
        let unitStr = ""
        let rulersHeight = DYScrollRulerView.rulerViewHeight
        print(rulersHeight)
       
        var timerView = DYScrollRulerView.init(frame: CGRect.init(x: 5, y: 500, width: Int(ScreenWidth)-20, height: rulersHeight()), tminValue: 0, tmaxValue: 23, tstep: 0.2, tunit: unitStr, tNum: 5)
        timerView.bgColor       = UIColor.orange
        timerView.triangleColor = UIColor.blue
        timerView.delegate      = self
        timerView.scrollByHand  = true
        return timerView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(sview)
        self.view.addSubview(sview1)
        self.view.addSubview(sview2)
        self.view.addSubview(textField)
        self.view.addSubview(lazyRulerView)
//        self.view.addSubview(lazyTimeRullerView)
    }

}

extension ViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(valueChange), with: nil, afterDelay: 1)
        return true
    }
    
    func valueChange() {
        let currentText = textField.text ?? ""
        let newStr:NSString = currentText as NSString
        sview.changeRulerValue(value: CGFloat(newStr.floatValue))
    }
}

extension ViewController:QQMScrollRulerViewDelegate {
    func qqmscrollRulerViewValueChange(rulerView: QQMScrollRulerView, value: CGFloat) {
        print("滑动的值-------"+"\(value)")
        
        textField.text = "\(Int(value))"
        
        
    }
}


extension ViewController:DYScorllRulerDelegate {
    func dyScrollRulerViewValueChange(rulerView: DYScrollRulerView, value: Float) {
        print("滑动的值-------》"+"\(value)")
        
        textField.text = "\(Int(value))"
    }
}
