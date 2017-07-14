//
//  FunConst.swift
//  QQMProjectSwift
//
//  Created by liupuyan on 2017/5/15.
//  Copyright © 2017年 liupuyan. All rights reserved.
//

import Foundation
import UIKit

/// 打印日志
///
/// - Parameters:
///   - message: <#message description#>
///   - file: <#file description#>
///   - method: <#method description#>
///   - line: <#line description#>
func QQMLog<T>(message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if CONFIGURATION_Debug || CONFIGURATION_QQMTest
        print("\(method)[\(line)]: \(message)")
    #endif
}

/// 屏幕适配 输入iPhone6尺寸自动生成对应iPhone型号尺寸
///
/// - Parameter size: <#size description#>
/// - Returns: <#return value description#>
func ScreenAdaptationSizeOfIphone6(size: CGFloat) -> CGFloat {
    return (IPHONE4 || IPHONE5) ? size * (IPHONE4Width / IPHONE6Width) : (IPHONE6 ? size : size * (IPHONE6PWidth / IPHONE6Width))
}
