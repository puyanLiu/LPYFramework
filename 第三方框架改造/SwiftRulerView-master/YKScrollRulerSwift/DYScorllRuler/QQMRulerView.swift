//
//  QQMRulerView.swift
//  YKScrollRulerSwift
//
//  Created by liupuyan on 2017/7/13.
//  Copyright © 2017年 Daniel Yao. All rights reserved.
//

import UIKit

class QQMHeaderRulerView: UIView {
    
    var minValue: CGFloat = 0
    var unit: String = "" // 文字单位
    
    override func draw(_ rect: CGRect) {
        let lineY = rect.size.height - QQMRulerLongLine
        let topY: CGFloat = rect.size.height
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1)
        context?.setLineCap(.round)
        context?.setStrokeColor(QQMColor262626.cgColor)
        context?.setFillColor(UIColor.green.cgColor)
        let x: CGFloat = rect.size.width
        context?.move(to: CGPoint(x: x, y: topY))
        context?.addLine(to: CGPoint(x: x, y: lineY))
        context?.move(to: CGPoint(x: 0, y: topY))
        context?.addLine(to: CGPoint(x: rect.size.width, y: topY))
        context?.strokePath()
        let num: CGFloat = minValue
        var numStr: NSString = NSString(format: "%.f%@", num, unit)
        if num > 1000000 {
            numStr = NSString(format: "%f万%@", num / 10000, unit)
        }
        let attribute: Dictionary = [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: QQMColor262626_40]
        let width: CGFloat = numStr.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attribute, context: nil).size.width
        numStr.draw(in: CGRect(x: x - width * 0.5, y: 0, width: width, height: 12), withAttributes: attribute)
    }
    
}

class QQMRulerView: UIView {
    
    var minValue: CGFloat = 0
    var maxValue: CGFloat = 0
    var betweenNumber: Int = 1
    var step: CGFloat = 0 // 间隔值
    var unit: String = "" // 文字单位
    var isLongLine: Bool = true // 最后一段线默认为长线
    
    override func draw(_ rect: CGRect) {
        let startX: CGFloat = 0
        let lineCenterX: CGFloat = QQMRulerSpaceW
        let topY: CGFloat = rect.size.height
        let shortLineY = rect.size.height - QQMRulerShortLine
        let longLineY = rect.size.height - QQMRulerLongLine
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1)
        context?.setLineCap(.round)
        context?.setStrokeColor(QQMColor262626.cgColor)
        context?.move(to: CGPoint(x: 0, y: topY))
        context?.addLine(to: CGPoint(x: rect.size.width, y: topY))
        for i in 0...betweenNumber {
            let x: CGFloat = startX + lineCenterX * CGFloat(i)
            context?.move(to: CGPoint(x: x, y: topY))
            if i % betweenNumber == 0 {
                if i == betweenNumber {
                    context?.addLine(to: CGPoint(x: x, y: isLongLine ? longLineY : shortLineY))
                } else {
                    context?.addLine(to: CGPoint(x: x, y: longLineY))
                }
                context?.strokePath()
                let num: CGFloat = CGFloat(i) * step + minValue
                var numStr: NSString = NSString(format: "%.f%@", num, unit)
                if num > 1000000 {
                    numStr = NSString(format: "%f万%@", num / 10000, unit)
                }
                let attribute: Dictionary = [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: QQMColor262626_40]
                let width: CGFloat = numStr.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attribute, context: nil).size.width
                numStr.draw(in: CGRect(x: x - width * 0.5, y: 0, width: width, height: 12), withAttributes: attribute)
            } else {
                context?.addLine(to: CGPoint(x: x, y: shortLineY))
                context?.strokePath()
            }
        }
    }
    
}

class QQMFooterRulerView: UIView {
    
    var maxValue: CGFloat = 0
    var unit: String = "" // 文字单位
    var isLongLine: Bool = true // 最后一段线默认为长线
    
    override func draw(_ rect: CGRect) {
        let shortLineY = rect.size.height - QQMRulerShortLine
        let longLineY = rect.size.height - QQMRulerLongLine
        let topY: CGFloat = rect.size.height
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1)
        context?.setLineCap(.round)
        context?.setStrokeColor(QQMColor262626.cgColor)
        
        let x: CGFloat = 0
        context?.move(to: CGPoint(x: x, y: topY))
        context?.addLine(to: CGPoint(x: x, y: isLongLine ? longLineY : shortLineY))
        context?.move(to: CGPoint(x: 0, y: topY))
        context?.addLine(to: CGPoint(x: rect.size.width, y: topY))
        context?.strokePath()
        let num: CGFloat = maxValue
        var numStr: NSString = NSString(format: "%.f%@", num, unit)
        if num > 1000000 {
            numStr = NSString(format: "%f万%@", num / 10000, unit)
        }
        let attribute: Dictionary = [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: QQMColor262626_40]
        let width: CGFloat = numStr.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attribute, context: nil).size.width
        numStr.draw(in: CGRect(x: x - width * 0.5, y: 0, width: width, height: 12), withAttributes: attribute)
    }
    
}
