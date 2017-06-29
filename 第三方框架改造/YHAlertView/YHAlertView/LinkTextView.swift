//
//  LinkTextView.swift
//  YHAlertView
//
//  Created by liupuyan on 2017/6/29.
//  Copyright © 2017年 samuelandkevin. All rights reserved.
//

import UIKit

class LinkTextView: UITextView {

    private lazy var rectsArray: NSMutableArray = {
        let rectsArray = NSMutableArray()
        return rectsArray
    }()
    /**
     * <#desc#>
     */
    private var content: NSMutableAttributedString?
    private let coverViewTag = 111
    
    override var text: String! {
        didSet {
            // 设置的text的相关属性，都添加到 content 中
            content = NSMutableAttributedString()
            content?.addAttribute(NSFontAttributeName, value: font!, range: NSMakeRange(0, text.characters.count))
            if let color = textColor {
                content?.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, text.characters.count))
            }
        }
    }
    
    /// 设置textView的部分为下划线，并且使之可以点击
    /// 将下划线对用的文字的frame，文字内容，点击效果背景颜色存储起来，以供点击的时候查询
    ///
    /// - Parameters:
    ///   - underlineTextRange: 需要下划线的文字范围，如果NSRange范围超出总的内容，将过滤掉
    ///   - underlineColor: 下划线的颜色，以及下划线上面文字的颜色
    ///   - coverColor: 是否有点击的背景，如果设置相关颜色的话，将会有点击效果，如果为nil将没有
    ///   - block: 点击文字的时候的回调
    func setUnderlineText(underlineTextRange: NSRange, underlineColor: UIColor?, coverColor: UIColor?, block: OperationParamBlock?) {
        if self.text.characters.count < underlineTextRange.location + underlineTextRange.length {
            return
        }
        
        // 设置下划线
        content?.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue), range: underlineTextRange)
        attributedText = content
        // 设置下划线的文字的点击事件
        selectedRange = underlineTextRange
        // 获取选中范围内的矩形框
        let seleRects: NSArray = selectionRects(for: selectedTextRange!) as NSArray
        // 清空选中范围
        selectedRange = NSMakeRange(0, 0)
        // 可能会点击的范围的数组
        let selectedArray = NSMutableArray()
        for seleRect in seleRects {
            let seleR: UITextSelectionRect = seleRect as! UITextSelectionRect
            let rect = seleR.rect
            if (rect.size.width == 0 || rect.size.height == 0) {
                continue;
            }
            // 将有用的信息打包<存放到字典中>存储到数组中
            let dic = NSMutableDictionary()
            // 存储文字对应的frame，一段文字可能会有两个甚至多个frame，考虑到文字换行问题
            dic.setObject(rect, forKey: "rect" as NSCopying)
            // 存储下划线对应的文字
            dic.setObject(text.substring(with: text.range(from: underlineTextRange)!), forKey: "content" as NSCopying)
            // 存储相应的回调的block
            dic.setObject(block!, forKey: "block" as NSCopying)
            // 存储对应的点击效果背景颜色
            dic.setObject(coverColor!, forKey: "coverColor" as NSCopying)
            selectedArray.add(dic)
        }
        // 将可能点击的范围的数组存储到总的数组中
        rectsArray.addObjects(from: selectedArray as! [Any])
    }
    
    private func touchingSpecial(point: CGPoint) -> NSArray? {
        // 从所有的特殊的范围中找到点击的那个点
        for selectedArray in rectsArray {
            let selectedA: NSArray = selectedArray as! NSArray
            for dict in selectedA {
                let dictA: NSDictionary = dict as! NSDictionary
                let rect: CGRect = dictA.object(forKey: "rect") as! CGRect
                if rect.contains(point) {
                    return selectedA
                }
            }
        }
        return nil
    }
    
    // 点击textView的touchesBegan方法
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 获取触摸对象
        let touch: UITouch = touches.first!
        
        // 触摸点
        let point = touch.location(in: self)
        // 通过一个触摸点，查询点击的是不是在下划线对应的文字的frame
        if let selectedArray = touchingSpecial(point: point) {
            for dict in selectedArray {
                if let dictA: NSDictionary = dict as? NSDictionary {
                    if (dictA.object(forKey: "coverColor") != nil) {
                        let cover = UIView()
                        cover.backgroundColor = dictA.object(forKey: "coverColor") as? UIColor
                        cover.frame = dictA.object(forKey: "rect") as! CGRect
                        cover.layer.cornerRadius = 5
                        cover.tag = coverViewTag
                        insertSubview(cover, at: 0)
                    }
                }
            }
            if selectedArray.count > 0 {
                // 如果说有点击效果的话，加个延时，展示下点击效果,如果没有点击效果的话，直接回调
                let dict: NSDictionary = selectedArray.firstObject as! NSDictionary
                let block: OperationParamBlock = dict.object(forKey: "block") as! OperationParamBlock
                if (dict.object(forKey: "coverColor") != nil) {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .microseconds(200)) {
                        block(dict.object(forKey: "content"))
                    }
                } else {
                    block(dict.object(forKey: "content"))
                }
            }
        }
    }
    
    // 取消点击的时候，清除相关的阴影
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for subView in subviews {
            if subView.tag == coverViewTag {
                subView.removeFromSuperview()
            }
        }
    }
    
    // 点击结束的时候
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .microseconds(200)) {
            for subView in self.subviews {
                if subView.tag == self.coverViewTag {
                    subView.removeFromSuperview()
                }
            }
        }
    }

}
