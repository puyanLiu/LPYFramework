//
//  UIColor+Extension.swift
//  QQMProjectSwift
//
//  Created by liupuyan on 2017/5/12.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

import UIKit

extension UIColor {
    // 十六进制颜色转RGB
    convenience init(hexColor: String) {
        self.init(hexColor: hexColor, alpha: 1.0)
    }
    
    convenience init(hexColor: String, alpha: CGFloat) {
        var red: UInt32 = 0, green: UInt32 = 0, blue: UInt32 = 0
        // 分别转换
        Scanner(string: hexColor[0..<2]).scanHexInt32(&red)
        Scanner(string: hexColor[2..<4]).scanHexInt32(&green)
        Scanner(string: hexColor[4..<6]).scanHexInt32(&blue)
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
